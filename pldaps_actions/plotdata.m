function [PDS ,c ,s] = plotdata(PDS ,c ,s)


figure('Position', [20 900 1175 715]);

%% plot for diff locations
locs=[c.loc1deg c.loc2deg];
for locno=1:size(locs,2)
[hr_s(locno,:), hr_s_ci(locno,:)]=binofit(sum(PDS.changeloc==locs(locno) & PDS.trialtype==3 & PDS.dirchangetrial>0 & PDS.state==4.1),sum(PDS.changeloc==locs(locno) & PDS.trialtype==3 & PDS.dirchangetrial>0 & (PDS.state==4.1 | PDS.state==3.4)),0.05);
[hr(locno,:), hr_ci(locno,:)]=binofit(sum(PDS.changeloc==locs(locno) & PDS.trialtype==4 & PDS.dirchangetrial>0 & PDS.state==4.1),sum(PDS.changeloc==locs(locno) & PDS.trialtype==4 & PDS.dirchangetrial>0 & (PDS.state==4.1 | PDS.state==3.4)),0.05);

end
subplot(2,3,1)
cla
hold on
errorbar([1 2],hr,hr-hr_ci(:,1),hr_ci(:,2)-hr,'ks','MarkerEdgeColor', 'k', 'MarkerFaceColor' ,'k', 'MarkerSize',6);
hold on;
errorbar([1 2],hr_s,hr_s-hr_s_ci(:,1),hr_s_ci(:,2)-hr_s,'ko','MarkerEdgeColor', 'k', 'MarkerFaceColor' ,'k', 'MarkerSize',6);

set(gca,'FontSize',12,'TickDir','out')
set(gca,'xTicklabel',{'','HR Loc1', '','HR Loc2',''})
ylim([0 1]);
title('Perf. split on Locs');

%% plot for diff deltas
dels=[c.del 360-c.del];
for delno=1:size(dels,2)
    
[hrL1_S(delno,:), hrL1_S_ci(delno,:)]=binofit(  sum(PDS.loc1del==dels(delno) & PDS.changeloc==locs(1) & PDS.trialtype==3 & PDS.dirchangetrial>0 & PDS.state==4.1), ...
                                                sum(PDS.loc1del==dels(delno) & PDS.changeloc==locs(1) & PDS.trialtype==3 & PDS.dirchangetrial>0 & (PDS.state==4.1 | PDS.state==3.4)), 0.05);
[hrL2_S(delno,:), hrL2_S_ci(delno,:)]=binofit(  sum(PDS.loc2del==dels(delno) & PDS.changeloc==locs(2) & PDS.trialtype==3 & PDS.dirchangetrial>0 & PDS.state==4.1), ...
                                                sum(PDS.loc2del==dels(delno) & PDS.changeloc==locs(2) & PDS.trialtype==3 & PDS.dirchangetrial>0 & (PDS.state==4.1 | PDS.state==3.4)), 0.05);

    
[hrL1(delno,:), hrL1_ci(delno,:)]=binofit(  sum(PDS.loc1del==dels(delno) & PDS.changeloc==locs(1) & PDS.trialtype==4 & PDS.dirchangetrial>0 & PDS.state==4.1),...
                                            sum(PDS.loc1del==dels(delno) & PDS.changeloc==locs(1) & PDS.trialtype==4 & PDS.dirchangetrial>0 & (PDS.state==4.1 | PDS.state==3.4)), 0.05);
[hrL2(delno,:), hrL2_ci(delno,:)]=binofit(  sum(PDS.loc2del==dels(delno) & PDS.changeloc==locs(2) & PDS.trialtype==4 & PDS.dirchangetrial>0 & PDS.state==4.1), ...
                                            sum(PDS.loc2del==dels(delno) & PDS.changeloc==locs(2) & PDS.trialtype==4 & PDS.dirchangetrial>0 & (PDS.state==4.1 | PDS.state==3.4)), 0.05);

end
subplot(2,3,2)
hold on
errorbar([1 2],hrL1,hrL1-hrL1_ci(:,1),hrL1_ci(:,2)-hrL1,'ks','MarkerEdgeColor', 'c', 'MarkerFaceColor' ,'c', 'MarkerSize',6);
hold on;
errorbar([1 2],hrL2,hrL2-hrL2_ci(:,1),hrL2_ci(:,2)-hrL2,'ks','MarkerEdgeColor', 'm', 'MarkerFaceColor' ,'m', 'MarkerSize',6);
hold on;

errorbar([1 2],hrL1_S,hrL1_S-hrL1_S_ci(:,1),hrL1_S_ci(:,2)-hrL1_S,'ko','MarkerEdgeColor', 'c', 'MarkerFaceColor' ,'c', 'MarkerSize',6);
hold on;
errorbar([1 2],hrL2_S,hrL2_S-hrL2_S_ci(:,1),hrL2_S_ci(:,2)-hrL2_S,'ko','MarkerEdgeColor', 'm', 'MarkerFaceColor' ,'m', 'MarkerSize',6);

set(gca,'FontSize',12,'TickDir','out')
set(gca,'xTicklabel',{'',['+' num2str(c.del) 'deg'], '',['-' num2str(c.del) 'deg'],''})
ylim([0 1]);
legend('Loc1','Loc2');
title('Perf. split on deltas');
%%
%--

[phr1, pcihr1] = binofit(sum(PDS.trialtype==1 & PDS.fixchangetrial==1 & PDS.state==4.1),sum(PDS.trialtype==1 & PDS.fixchangetrial==1 & (PDS.state==4.1 | PDS.state==3.4)),0.05);
[pfa1, pcifa1] = binofit(sum(PDS.trialtype==1 & PDS.state==3.3),sum(PDS.trialtype==1 & PDS.timebrokefix==-1 & PDS.timebrokejoy==-1),0.05);

y1=[phr1 pfa1];
yl1=[pcihr1(1) pcifa1(1)];
yh1=[pcihr1(2) pcifa1(2)];

%--

[phr2, pcihr2] = binofit(sum(PDS.trialtype==2 & PDS.fixchangetrial==1 & PDS.state==4.1),sum(PDS.trialtype==2 & PDS.fixchangetrial==1 & (PDS.state==4.1 | PDS.state==3.4)),0.05);
[pfa2, pcifa2] = binofit(sum(PDS.trialtype==2 &  PDS.state==5),sum(PDS.trialtype==2 & PDS.dirchangetrial>0 & (PDS.dirchangetime < PDS.fpchangetime+c.rewardwait) & (PDS.state==4.1 | PDS.state==3.4 | PDS.state==4.2 |PDS.state==5)),0.05);

y2=[phr2 pfa2];
yl2=[pcihr2(1) pcifa2(1)];
yh2=[pcihr2(2) pcifa2(2)];

%--

[phr3, pcihr3] = binofit(sum(PDS.trialtype==4 & PDS.dirchangetrial>0 & PDS.state==4.1),sum(PDS.trialtype==4  & PDS.dirchangetrial>0 & (PDS.state==4.1 | PDS.state==3.4)),0.05);
[pfa3, pcifa3] = binofit(sum(PDS.trialtype==4 & PDS.state==3.3),sum(PDS.trialtype==4 & PDS.timebrokefix==-1 & PDS.timebrokejoy==-1),0.05);

y3=[phr3 pfa3];
yl3=[pcihr3(1) pcifa3(1)];
yh3=[pcihr3(2) pcifa3(2)];

x=[1 2 3 4 5 6];
y=[y1 y2 y3];
yl=[yl1 yl2 yl3];
yh=[yh1 yh2 yh3];
yl=y-yl;
yh=yh-y;
subplot(2,3,3)
cla
hold on
 errorbar(x,y,yl,yh,'ks','MarkerEdgeColor', 'k', 'MarkerFaceColor' ,'k', 'MarkerSize',6);
 set(gca,'FontSize',9,'TickDir','out')
set(gca,'xTicklabel',{'', 'HR B', 'fas B', 'HR FA', 'fas FA','HR PA', 'fas PA'})
ylabel('%','FontSize',16,'FontWeight','bold')
% ylim([min(y)-5 max(y)+5]);
xlim([0 7]);
ylim([0 1]);

%%
% Plot joystick-release reaction-times (ms)
subplot(2,3,4)
cla;
hold on
plot(PDS.trialnumber(PDS.trialtype==1 & PDS.fixchangetrial==1 & PDS.state==4.1),1000.*(PDS.timejoyrel(PDS.trialtype==1 & PDS.fixchangetrial==1 & PDS.state==4.1)-PDS.fpchangetime(PDS.trialtype==1 & PDS.fixchangetrial==1 & PDS.state==4.1)),'r.','MarkerSize',12)
hold off
set(gca,'FontSize',12,'TickDir','out')
xlabel('Trial Number','FontSize',16,'FontWeight','bold')
ylabel('Joystick Release RTs (ms)','FontSize',16,'FontWeight','bold')
title('B trials','FontSize',16,'FontWeight','bold')
ylim([200 800]);

subplot(2,3,5)
cla;
hold on
plot(PDS.trialnumber(PDS.trialtype==2 & PDS.fixchangetrial==1 & PDS.state==4.1),1000.*(PDS.timejoyrel(PDS.trialtype==2 & PDS.fixchangetrial==1 & PDS.state==4.1)-PDS.fpchangetime(PDS.trialtype==2 & PDS.fixchangetrial==1 & PDS.state==4.1)),'b.','MarkerSize',12)
hold off
set(gca,'FontSize',12,'TickDir','out')
xlabel('Trial Number','FontSize',16,'FontWeight','bold')
ylabel('Joystick Release RTs (ms)','FontSize',16,'FontWeight','bold')
title('FA trials','FontSize',16,'FontWeight','bold')
ylim([200 800]);

subplot(2,3,6)
cla;
hold on
plot(PDS.trialnumber(PDS.trialtype==3 & PDS.dirchangetrial>0 & PDS.state==4.1),1000.*(PDS.timejoyrel(PDS.trialtype==3 & PDS.dirchangetrial>0 & PDS.state==4.1)-PDS.dirchangetime(PDS.trialtype==3 & PDS.dirchangetrial>0 & PDS.state==4.1)),'k.','MarkerSize',12)
hold on;
plot(PDS.trialnumber(PDS.trialtype==4 & PDS.dirchangetrial>0 & PDS.state==4.1),1000.*(PDS.timejoyrel(PDS.trialtype==4 & PDS.dirchangetrial>0 & PDS.state==4.1)-PDS.dirchangetime(PDS.trialtype==4 & PDS.dirchangetrial>0 & PDS.state==4.1)),'g.','MarkerSize',12)
hold off
set(gca,'FontSize',12,'TickDir','out')
xlabel('Trial Number','FontSize',16,'FontWeight','bold')
ylabel('Joystick Release RTs (ms)','FontSize',16,'FontWeight','bold')
title('PA trials','FontSize',16,'FontWeight','bold')
ylim([200 800]);

end