%% plot P2P trading analysis
clear all
%close all

figure
%subplot(2,1,1)
hold on, grid on, box on

dat{1} = 'sim_jext_C_con_11-Feb-2021_1.mat';
dat{2} = 'sim_jext_C_con_11-Feb-2021_2.mat';
dat{3} = 'sim_jext_C_con_11-Feb-2021_3.mat';
dat{4} = 'sim_jext_C_con_11-Feb-2021_4.mat';
dat{5} = 'sim_jext_C_09-Feb-2021 _5.mat';
%dat{3} = 'sim37b_B_0412_3.mat';
%dat{4} = 'sim37b_B_0412_4.mat';
%dat{5} = 'sim37b_B_0412_5.mat';
%dat{6} = 'sim37b_B_sce_3_ct500.mat';
dat{6} = 'case_jext_C_con_11-Feb-2021.mat';
load(dat{6})
for c=1:4
    


    load(dat{c});

   Ptr_t = zeros(np.h,1);
    for i=1:np.n
        for jj = 1:length(np.N{i})
            j = np.N{i}(jj);
            %if j > i
                %if c==3
                %    Ptr_t = Ptr_t + max(0,o.p_tr{i,j}(:,end));
               % else
                    Ptr_t = Ptr_t + max(0,o.p_tr{i,j}(:,end));
                %end
            %end
        end
    end

%    Pdt = sum(np.Pd);

    plot(Ptr_t,'LineWidth',1.2)
    clearvars('Ptr_t')
end
%plot(Pdt,'--o','color','k','LineWidth',1.5)
title('\textbf{P2P trading with different prices of trading}','Interpreter','latex')
ylabel('Power [KW]','Interpreter','latex')
%legend({['cost coef.=',num2str(np.ctrl(3))],['cost coef.=',num2str(np.ctrl(1))],['cost coef.=',num2str(np.ctrl(2))],['cost coef.=',num2str(np.ctrl(4))],['heterogeneous cost coef.']},'Interpreter','latex'  )
%ylim([100, 200])
%%

figure%subplot(2,1,2)
hold on, grid on, box on,

% dat{1} = 'sim37b_B_spar_1.mat';
% dat{2} = 'sim37b_B_spar_2.mat';
% dat{3} = 'sim37b_B_spar_3.mat';
dat{1} = 'sim37b_B2_sp_1.mat';
dat{2} = 'sim37b_B2_sp_2.mat';
dat{3} = 'sim37b_B2_sp_3.mat';
for c=1:3


    load(dat{c});
    
    Ptr_t = zeros(np.h,1);
    for i=1:np.n
        for j = 1:np.n
            if j > i && ~isempty(s.p_tr{i,j})
                Ptr_t = Ptr_t + abs(s.p_tr{i,j}(:,end));
            end
        end
    end

%    Pdt = sum(np.Pd);

    plot(Ptr_t,'LineWidth',1.2)
    
end
%plot(Pdt,'--o','color','k','LineWidth',1.5)
title('\textbf{P2P trading with different level of connectivity}','Interpreter','latex')
ylabel('Power [KW]','Interpreter','latex')
xlabel('time step [hour]','Interpreter','latex')
legend({'connectivity=0.1','connectivity=0.4','connectivity=0.7'},'Interpreter','latex'  )
%ylim([100, 200])

%%
figure
subplot(2,1,1)
hold on, grid on, box on

dat{1} = 'sim37b_B5_1.mat';
dat{2} = 'sim37b_B5_2.mat';
dat{3} = 'sim37b_B5_3.mat';
dat{4} = 'sim37b_B5_4.mat';
dat{5} = 'sim37b_B5_5.mat';
%dat{6} = 'sim37b_B_sce_3_ct500.mat';
dat{6} = 'case_37b_B5_base.mat';
load(dat{6})
for c=1:5


    load(dat{c});

   Ptr_t = zeros(np.h,1);
    for i=1:np.n
        for j = 1:np.n
            if j > i && ~isempty(s.p_tr{i,j})
                Ptr_t = Ptr_t + abs(s.p_tr{i,j}(:,end));
            end
        end
    end

%    Pdt = sum(np.Pd);

    plot(Ptr_t,'LineWidth',1.2)
    
end
%plot(Pdt,'--o','color','k','LineWidth',1.5)
title('\textbf{P2P trading with different cost}','Interpreter','latex')
ylabel('Power [KW]','Interpreter','latex')
legend({'cost coef.=0.1','cost coef.=1','cost coef.=10','cost coef.=100','cost coef.=1000'},'Interpreter','latex'  )
%ylim([100, 200])
%%

subplot(2,1,2)
hold on, grid on, box on,

dat{1} = 'sim37b_B4_sp_1.mat';
dat{2} = 'sim37b_B4_sp_4.mat';
dat{3} = 'sim37b_B4_sp_7.mat';

for c=1:3


    load(dat{c});
    
    Ptr_t = zeros(np.h,1);
    for i=1:np.n
        for j = 1:np.n
            if j > i && ~isempty(s.p_tr{i,j})
                Ptr_t = Ptr_t + abs(s.p_tr{i,j}(:,end));
            end
        end
    end

%    Pdt = sum(np.Pd);

    plot(Ptr_t,'LineWidth',1.2)
    
end
%plot(Pdt,'--o','color','k','LineWidth',1.5)
title('\textbf{P2P trading with different level of connectivity}','Interpreter','latex')
ylabel('Power [KW]','Interpreter','latex')
xlabel('time step [hour]','Interpreter','latex')
legend({'connectivity=0.1','connectivity=0.4','connectivity=0.7'},'Interpreter','latex'  )
%ylim([100, 200])
 