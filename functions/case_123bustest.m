% Generate a case using IEEE 123-bus network

% set time horizon
np.h= 6;


%% Adjacency matrix of trading network
np.n = n_agents;
np.Adj = sparse(randconG(np.n,0.4));

np.pas_ag = n_passive;
%% Adjacency matrix of physical network
np.b = 118;
np.Adj_p = zeros(np.b);
np.Bnet = zeros(np.b);
np.Gnet = zeros(np.b);

% operating voltage
np.v_op = 4.16^2*1000; %kV

load('case_123_line.mat');
tab = case_123bus;
for i= 1:length(tab(:,1))
    np.Adj_p(tab(i,1),tab(i,2)) = 1;
    
    if  tab(i,4) == 1
        z_b = 0.4576 + 1.078i;
    elseif tab(i,4) == 2
        z_b = 0.4666 + 1.0482i;
    elseif tab(i,4) == 3
        z_b = 0.4615 + 1.0651i;
    elseif tab(i,4) == 4
        z_b = 0.4615 + 1.0651i;
    elseif tab(i,4) == 5
        z_b = 0.4666 + 1.0482i;
    elseif tab(i,4) == 6
        z_b = 0.4576 + 1.078i;
    elseif tab(i,4) == 7
        z_b = 0.4576 + 1.078i;
    elseif tab(i,4) == 8
        z_b = 0.4576 + 1.078i;
    elseif tab(i,4) == 9
        z_b = 1.3292 + 1.3475i;
    elseif tab(i,4) == 10
        z_b = 1.3292 + 1.3475i;
    elseif tab(i,4) == 11
        z_b = 1.3292 + 1.3475i;
    elseif tab(i,4) == 12
        z_b = 1.5209 + 0.7521i;    
    end
    z= z_b*tab(i,3)/5280;
    np.Bnet(tab(i,1),tab(i,2)) = imag(1/z);
    np.Gnet(tab(i,1),tab(i,2)) = real(1/z);
end
np.Adj_p = sparse(np.Adj_p + np.Adj_p');
np.Bnet = sparse(np.Bnet + np.Bnet');
np.Bnet = np.v_op*np.Bnet;
np.Gnet = sparse(np.Gnet + np.Gnet');
np.Gnet = np.v_op*np.Gnet;

% index of bus where each prosumer is connected to
%np.B_n = idx_bus(np.N_b,np.n);
np.B_n = randperm(np.b,mod(np.n,np.b));
for i = 1:floor(np.n/np.b)
    np.B_n = [np.B_n randperm(np.b,np.b)];
end

% set of prosumers attached to the bus
for y=1:np.b
    np.N_b{y}= find(np.B_n==y);
end

% index of bus where each passive agent is connected to
%np.B_n = idx_bus(np.N_b,np.n);
np.B_pas = randperm(np.b,mod(np.pas_ag,np.b));
np.B_pas = np.B_pas;
for i = 1:floor(np.pas_ag/np.b)
    np.B_pas = [np.B_pas randperm(np.b,np.b)];
end

% set of passive agents attached to the bus
for y=1:np.b
    np.Pasag_b{y}= find(np.B_pas==y);
end

% Busses connected to the main grid
np.B_mg = [118];

%% assign components to each agent
n = np.n;
b = np.pas_ag;
% type of load
% randomly assign the type of load profile   
np.t_lpr = randi([1 6], n+b,1);
% 0 = no load
%np.t_lpr(n+1) = 0;
%np.t_lpr(n+7) = 0;
%np.t_lpr(n+8) = 0;
    
% storage units (no storage units in [Sousa, et. al.,2019] and [Le Cadre, et al, 2019]
%np.st_un = zeros(n,1);
n_st=floor(np.n/2);
 ag_st = randperm(np.n,n_st); 
 np.st_un = zeros(n,1);
 for i = 1:n_st
     np.st_un(ag_st(i)) = 1;
end

% dispatchable units
%np.d_un = randi([0 1], n,1);
%np.d_un = [ones(1, 10) zeros(1,n-10)];

 n_di=floor(np.n/4);
 ag_dg = randperm(np.n,n_di); 
 np.d_un = zeros(n,1);
 for i = 1:n_di
     np.d_un(ag_dg(i)) = 1;
end
%np.d_un = zeros(n,1);

% PV generation units
np.r_un = zeros(n+b,1);
for i=1:n
    if np.st_un == 1
        np.r_un(i) = randi([0 4]);
    end
end



% assign parameters in the local constraints
np = gen_param(np,ty); 



% generate load and non-dispatchable profiles
[np.Pd,np.Pl,np.Pr] = gen_Pd_ext(np.n,np.t_lpr,np.r_un,np.pas_ag);

% h steps, from 12:00 where h<12
np.Pd = np.Pd(:,12:12+np.h-1);

np.sumPd = sum(np.Pd(np.n+1:end,:))';

% initial condition of variables
np.init = 0;

% assign per-unit costs
np = gen_cost(np,tc); 
