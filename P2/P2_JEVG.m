%% Clear the window and data, Put a valor to variables 

clc, clear
close all;
x=0:0.1:10;
A=x./(x+2);
B=2.^(-x);
C=1./(1+10*(x-2).^2);

%% Assign Operations  

%Complements
Complement_A=1-A;
Complement_B=1-B;
Complement_C=1-C;
    %Unions
    AuB=max(A,B);
    AuC=max(A,C);
    BuC=max(B,C);
        %Intersections
        AnB=min(A,B);
        AnC=min(A,C);
        BnC=min(B,C);
            %Morgan Laws
            a=1-(min(A,Complement_C));
            b=1-(min(C,Complement_B));
            c=1-AuC;

%% Plot the images in the same figure
Fig = figure('Name', 'Fuzzy Sets - Basic Operations  - JEVG');
set(Fig, 'Position', [0 0 4000 2000])
%Complement of A
subplot(4,3,1)
hold on
plot(x,A,'color','blue','linewidth',1)
plot(x,Complement_A,'color','magenta','linewidth',2)
ylabel('Complements')
title('Complement of A','($A/\bar{A}$)','interpreter','latex',FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13)
grid on, hold off
legend({'A','Ac'},'Location','east','Orientation','vertical')
%Complement of B
subplot(4,3,2)
hold on
plot(x,B,'color','red','linewidth',1)
plot(x,Complement_B,'color','magenta','linewidth',2)
title('Complement of B','($B/\bar{B}$)','interpreter','latex',FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13)
grid on, hold off
legend({'B','Bc'},'Location','east','Orientation','vertical')
%Complement of C
subplot(4,3,3)
hold on
plot(x,C,'color','green','linewidth',1)
plot(x,Complement_C,'color','magenta','linewidth',2)
title('Complement of C','($C/\bar{C}$)','interpreter','latex',FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13)
grid on, hold off
legend({'C','Cc'},'Location','east','Orientation','vertical')

    %A union B
    subplot(4,3,4)
    hold on
    plot(x,A,'color','blue','linewidth',1)
    plot(x,B,'color','red','linewidth',1)
    plot(x,AuB,'-.','color','magenta','linewidth',2)
    ylabel('Unions')
    title('A union B','($A\vee B$)','interpreter','latex',FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13)
    grid on, hold off
    legend({'A','B','AuB'},'Location','east','Orientation','vertical')
    %A union C
    subplot(4,3,5)
    hold on
    plot(x,A,'color','blue','linewidth',1)
    plot(x,C,'color','green','linewidth',1)
    plot(x,AuC,'-.','color','magenta','linewidth',2)
    title('A union C','($A\vee C$)','interpreter','latex',FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13)
    hold off
    legend({'A','C','AuC'},'Location','east','Orientation','vertical')
    %B union C
    subplot(4,3,6)
    grid on, hold on
    plot(x,B,'color','red','linewidth',1)
    plot(x,C,'color','green','linewidth',1)
    plot(x,BuC,'-.','color','magenta','linewidth',2)
    title('B union C','($B\vee C$)','interpreter','latex',FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13)
    grid on, hold off
    legend({'B','C','BuC'},'Location','east','Orientation','vertical')

%A intersection B
subplot(4,3,7)
hold on
plot(x,A,'color','blue','linewidth',1)
plot(x,B,'color','red','linewidth',1)
plot(x,AnB,'-.','color','magenta','linewidth',2)
ylabel('Intersections')
title('A Intersection B','($A\wedge B$)','interpreter','latex',FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13)
grid on, hold off
legend({'A','B','AnB'},'Location','east','Orientation','vertical')
%A intersection C
subplot(4,3,8)
hold on
plot(x,A,'color','blue','linewidth',1)
plot(x,C,'color','green','linewidth',1)
plot(x,AnC,'-.','color','magenta','linewidth',2)
title('A intersection C','($A\wedge C$)','interpreter','latex',FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13)
grid on, hold off
legend({'A','C','AnC'},'Location','east','Orientation','vertical')
%B intersection C
subplot(4,3,9)
hold on
plot(x,B,'color','red','linewidth',1)
plot(x,C,'color','green','linewidth',1)
plot(x,BnC,'-.','color','magenta','linewidth',2)
title('B intersection C','($B\wedge C$)','interpreter','latex',FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13)
grid on, hold off
legend({'B','C','BnC'},'Location','east','Orientation','vertical')


    %Morgan Law a.
    subplot(4,3,10)
    hold on
    plot(x,A,'color','blue','linewidth',1)
    plot(x,C,'color','green','linewidth',1)
    plot(x,a,'-.','color','magenta','linewidth',2)
    xlabel('x')
    ylabel('Fuzzy Sets: Morgan Laws ')
    title('Morgan Law a.','($\overline{A\wedge\overline{C}}$)','interpreter','latex',FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13)
    grid on, hold off
    legend({'A','C','Morgan a.'},'Location','east','Orientation','vertical')
    %Morgan Law b.
    subplot(4,3,11)
    hold on
    plot(x,B,'color','red','linewidth',1)
    plot(x,C,'color','green','linewidth',1)
    plot(x,b,'-.','color','magenta','linewidth',2)
    xlabel('x')
    title('Morgan Law b.','($\overline{\overline{B}\wedge C}$)','interpreter','latex',FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13)
    grid on, hold off
    legend({'B','C','Morgan b.'},'Location','east','Orientation','vertical')
    %Morgan Law c.
    subplot(4,3,12)
    hold on
    plot(x,A,'color','blue','linewidth',1)
    plot(x,C,'color','green','linewidth',1)
    plot(x,c,'-.','color','magenta','linewidth',2)
    xlabel('x')
    title('Morgan Law c.','($\overline{A\vee C}$)','interpreter','latex',FontWeight='bold',FontSize=13,FontWeight='bold',FontSize=13)
    grid on, hold off 
    legend({'A','C','Morgan c.'},'Location','east','Orientation','vertical')

