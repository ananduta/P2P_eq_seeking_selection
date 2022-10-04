%%
%load('sim_A9_inert06-Jun-2022.mat')


% load A13
q1 = q;
%% load A12
for i = 1:3
    q1.erStd{2+i} = q.erStd{i};
    q1.erOvr{2+i} = q.erOvr{i};
    q1.erIne{2+i} = q.erIne{i};
end


%ord = [5, 1, 4, 3, 2];
ord = [2, 5, 4, 3, 1];
%ord = [1, 5, 4, 3, 2];
%q1 = q;
for i = 1:length(ord)
    ii = ord(i);
    q.erStd{i} = q1.erStd{ii};
    q.erOvr{i} = q1.erOvr{ii};
    q.erIne{i} = q1.erIne{ii};
end

nAg = [80 98 115 133 150];







%% When 80 and 150 are separated
n = 8;
load(['sim_A_12_80_',num2str(n),'.mat'])
q1.erStd{1} = q.erStd{1};
q1.erOvr{1} = q.erOvr{1};
q1.erIne{1} = q.erIne{1};
load(['sim_A_12_150_',num2str(n),'.mat'])
q1.erStd{2} = q.erStd{1};
q1.erOvr{2} = q.erOvr{1};
q1.erIne{2} = q.erIne{1};

%% load A12
for i = 1:3
    q1.erStd{2+i} = q.erStd{i};
    q1.erOvr{2+i} = q.erOvr{i};
    q1.erIne{2+i} = q.erIne{i};
end


%ord = [5, 1, 4, 3, 2];
%ord = [2, 5, 4, 3, 1];
ord = [1, 5, 4, 3, 2];
%q1 = q;
for i = 1:length(ord)
    ii = ord(i);
    q.erStd{i} = q1.erStd{ii};
    q.erOvr{i} = q1.erOvr{ii};
    q.erIne{i} = q1.erIne{ii};
end

nAg = [80 98 115 133 150];


%% 
ord = [5, 4, 3, 2, 1];
q1 = q;
for i = 1:length(ord)
    ii = ord(i);
    q.erStd{i} = q1.erStd{ii};
    q.erOvr{i} = q1.erOvr{ii};
    q.erIne{i} = q1.erIne{ii};
end

nAg = [80 98 115 133 150];