% Simulations
% extended P2P market, single simulation
% Test inertial and overrelaxed PPP
% W. Ananduta
% 02/05/2022


clear all
close all
clc

run('pathdef.m')
%rng(310822)
% Add path of folder 'functions'
addpath([pwd,'/functions'])
%addpath([pwd,'/functions/osqp'])

ty = [0]; %type of case study: (0)heterogenous  or (1)uniform  agents
tc = [1]; %uniform trading cost

% set the number of agents
n_agents = 100;
n_passive = 50;

% generate case
%run('case_37bus_N.m')
run('case_123bustest.m')

% identify set of neighbors
np.N = id_neigh(np.Adj);
np.B = id_neigh(np.Adj_p);


% selections of line capacity constraints
%sb = [((np.n+np.pas_ag)/np.b+2)*600 ((np.n+np.pas_ag)/np.b+2)*300]; % PARAMETERS VARIED

%np.sb_set = sb;

save(['case_sim_B_',date],'np')
%% 
for cc = 3
        
    % set line capacity constraint
    %np.s_bar = sb(cc)*ones(np.b);

    
    if cc ==1
        [s1,sl1,np1] = ppp(np);
        % compute total cost
        [s1,o{cc}] = com_cost(s1,np1);     
        %o{cc}.comp_time = s1.comp_time;
        o{cc}.error = s1.error;
        o{cc}.error_v = s1.error_v;
        
    elseif cc == 2
        [s2,sl2,np2] = ppp_hsdm(np);
        % compute total cost
        [s2,o{cc}] = com_cost(s2,np2);     
        %o{cc}.comp_time = s2.comp_time;
        o{cc}.error = s2.error;
        o{cc}.error_v = s2.error_v;
    
    elseif cc == 3
        [s3,sl3,np3] = sd_alg_eP2P_l1_DSO2(np);
        % compute total cost
        [s3,o{cc}] = com_cost(s3,np3);     
        %o{cc}.comp_time = s2.comp_time;
        o{cc}.error = s3.error;
        o{cc}.error_v = s3.error_v;
    end
    
    r = o{cc};
    save(['sim_B3_hsdm',date,'_',num2str(cc)],'r','o')
    %clearvars('s','sl');

end
save(['sim_B3_hsdm',date],'o','np')