clc;
clear;

% Bus Data Format: [Bus, Type (1=Slack, 2=PV, 3=PQ), PG, QG, PL, QL, V, Angle]
bus_data = [
    1, 1, 0, 0, 0, 0, 1.00, 0.00;
    2, 2, 150, 0, 0, 0, 1.00, 0.00;
    3, 2, 150, 0, 0, 0, 1.00, 0.00;
    4, 3, 0, 0, 115, 16, 1.00, 0.00;
    5, 3, 0, 0, 115, 16, 1.00, 0.00;
    6, 3, 0, 0, 115, 16, 1.00, 0.00;
    7, 3, 0, 0, 115, 16, 1.00, 0.00;
    8, 3, 0, 0, 115, 16, 1.00, 0.00;
    9, 3, 0, 0, 115, 16, 1.00, 0.00;
];

%Line Data Format: [From, To, R (pu), X (pu)]
line_data = [
    1, 4, 0.0032, 0.0256;
    4, 5, 0.0032, 0.0256;
    5, 2, 0.0032, 0.0256;
    5, 6, 0.0032, 0.0256;
    2, 7, 0.0032, 0.0256;
    3, 6, 0.0032, 0.0256;
    3, 9, 0.0032, 0.0256;
    8, 9, 0.0032, 0.0256;
    6, 7, 0.0032, 0.0256;
    7, 9, 0.0032, 0.0256;
];

n_bus = size(bus_data,1);
bus_type = bus_data(:,2);
slack_idx = find(bus_type == 1);
pv_idx = find(bus_type == 2);
pq_idx = find(bus_type == 3);

%Y-Bus
Ybus = zeros(n_bus);
for k = 1:size(line_data,1)
    from = line_data(k,1);
    to = line_data(k,2);
    R = line_data(k,3);
    X = line_data(k,4);
    Z = R + 1i*X;
    Y = 1/Z;
    Ybus(from, to) = Ybus(from, to) - Y;
    Ybus(to, from) = Ybus(from, to);
    Ybus(from, from) = Ybus(from, from) + Y;
    Ybus(to, to) = Ybus(to, to) + Y;
end

% Initial Values
V = bus_data(:,7);
delta = deg2rad(bus_data(:,8));
S_gen = (bus_data(:,3) - bus_data(:,5)) / 100;  
Q_gen = (bus_data(:,4) - bus_data(:,6)) / 100;  

PQ = [pv_idx; pq_idx];
Qonly = pq_idx;        

max_iter = 10000;
tol = 1e-6;

% Newton-Raphson Iteration
for iter = 1:max_iter
    P = zeros(n_bus,1);
    Q = zeros(n_bus,1);
    
    for i = 1:n_bus
        for k = 1:n_bus
            Y_mag = abs(Ybus(i,k));
            Y_ang = angle(Ybus(i,k));
            P(i) = P(i) + V(i)*V(k)*Y_mag*cos(delta(i)-delta(k)-Y_ang);
            Q(i) = Q(i) + V(i)*V(k)*Y_mag*sin(delta(i)-delta(k)-Y_ang);
        end
    end
    
    dP = S_gen(PQ) - P(PQ);
    dQ = Q_gen(Qonly) - Q(Qonly);
    mismatch = [dP; dQ];
    
    if max(abs(mismatch)) < tol
        break;
    end
    
    % Jacobian
    J11 = zeros(length(PQ));
    J12 = zeros(length(PQ), length(Qonly));
    J21 = zeros(length(Qonly), length(PQ));
    J22 = zeros(length(Qonly));
    
    for i = 1:length(PQ)
        m = PQ(i);
        for j = 1:length(PQ)
            n = PQ(j);
            if m == n
                sum_term = 0;
                for k = 1:n_bus
                    if k ~= m
                        sum_term = sum_term + V(m)*V(k)*abs(Ybus(m,k))*sin(delta(m)-delta(k)-angle(Ybus(m,k)));
                    end
                end
                J11(i,j) = -sum_term;
            else
                J11(i,j) = V(m)*V(n)*abs(Ybus(m,n))*sin(delta(m)-delta(n)-angle(Ybus(m,n)));
            end
        end
    end
    
    for i = 1:length(PQ)
        m = PQ(i);
        for j = 1:length(Qonly)
            n = Qonly(j);
            if m == n
                sum_term = 0;
                for k = 1:n_bus
                    sum_term = sum_term + V(k)*abs(Ybus(m,k))*cos(delta(m)-delta(k)-angle(Ybus(m,k)));
                end
                J12(i,j) = sum_term + 2*V(m)*abs(Ybus(m,m))*cos(angle(Ybus(m,m)));
            else
                J12(i,j) = V(m)*abs(Ybus(m,n))*cos(delta(m)-delta(n)-angle(Ybus(m,n)));
            end
        end
    end
    
    for i = 1:length(Qonly)
        m = Qonly(i);
        for j = 1:length(PQ)
            n = PQ(j);
            if m == n
                sum_term = 0;
                for k = 1:n_bus
                    if k ~= m
                        sum_term = sum_term + V(m)*V(k)*abs(Ybus(m,k))*cos(delta(m)-delta(k)-angle(Ybus(m,k)));
                    end
                end
                J21(i,j) = sum_term;
            else
                J21(i,j) = -V(m)*V(n)*abs(Ybus(m,n))*cos(delta(m)-delta(n)-angle(Ybus(m,n)));
            end
        end
    end
    
    for i = 1:length(Qonly)
        m = Qonly(i);
        for j = 1:length(Qonly)
            n = Qonly(j);
            if m == n
                sum_term = 0;
                for k = 1:n_bus
                    sum_term = sum_term + V(k)*abs(Ybus(m,k))*sin(delta(m)-delta(k)-angle(Ybus(m,k)));
                end
                J22(i,j) = -sum_term - 2*V(m)*abs(Ybus(m,m))*sin(angle(Ybus(m,m)));
            else
                J22(i,j) = -V(m)*abs(Ybus(m,n))*sin(delta(m)-delta(n)-angle(Ybus(m,n)));
            end
        end
    end
    
    J = [J11 J12; J21 J22];
    dx = J \ mismatch;
    
    delta(PQ) = delta(PQ) + dx(1:length(PQ));
    V(Qonly) = V(Qonly) + dx(length(PQ)+1:end);
end

% Final Results
V_mag = V;
V_angle = rad2deg(delta);
S = (V_mag .* exp(1i*delta)) .* conj(Ybus * (V_mag .* exp(1i*delta)));
P_out = real(S) * 100;
Q_out = imag(S) * 100;

fprintf('\nFinal Bus Voltages and Angles:\n');
disp(table((1:n_bus)', V_mag, V_angle, 'VariableNames', {'Bus', 'Voltage (pu)', 'Angle (deg)'}));

fprintf('\nFinal Power at Each Bus:\n');
fprintf('Bus\t|  P_inj (MW)\t|  Q_inj (MVAr)\n');
fprintf('------------------------------------------\n');
for i = 1:n_bus
    fprintf('%d\t|  %8.3f\t|  %8.3f\n', i, P_out(i), Q_out(i));
end

% Power Flow on Transmission Lines
fprintf('\nPower Flows on Transmission Lines:\n');
fprintf('From\tTo\t|  P (MW)\tQ (MVAr)\n');
fprintf('------------------------------------------\n');

V_complex = V_mag .* exp(1i * delta);

for k = 1:size(line_data,1)
    from = line_data(k,1);
    to = line_data(k,2);
    R = line_data(k,3);
    X = line_data(k,4);
    Z = R + 1i * X;
    Y = 1 / Z;
    
    I_ij = (V_complex(from) - V_complex(to)) * Y;
    S_ij = V_complex(from) * conj(I_ij);
    
    P_ij = real(S_ij) * 100;  
    Q_ij = imag(S_ij) * 100;  
    
    fprintf('%d\t%d\t|  %8.3f\t%8.3f\n', from, to, P_ij, Q_ij);
end
