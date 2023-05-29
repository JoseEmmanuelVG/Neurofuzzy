clear; clc; close all;
% Configure serial port
serialPort = 'COM3'; % Change according to your serial port
s = serial(serialPort, 'BaudRate', 9600);
% Close connection on termination
cleanupObj = onCleanup(@()closeSerial(s));

distance=5;
temperature=10;
try
    set(s,'Timeout',10); % Configurar tiempo de espera de 10 segundos
    fopen(s); % Abrir conexión
    while 1
        %Leemos del arduino
        dataStr = fgets(s); % Read a complete line
        dataValues = sscanf(dataStr, '%f,%f'); % Convert string to numbers
        if length(dataValues) == 2 
            distance = dataValues(1);
            temperature = dataValues(2);
            disp(['Distance: ', num2str(distance), ' cm']);
            disp(['Temperature: ', num2str(temperature), ' C']);
        else
            disp('Error in data received');
        end
        
        %Mamdani:
        %Entradas
        F=uint8(temperature);
        G=uint8(distance);
        F=F+1;
        G=G;
        
        %Temperature
        figure (1),
            %Ajustar al tamaño de la pantalla y titulo
            set(gcf, 'Color', 'w');
            set(gcf, 'Position', get(0, 'Screensize'));
            set(gcf, 'Units', 'normalized', 'Position', [0 0 1 1]);
        subplot(3,1,1)
        [u1,C]=trapezoidal(10,50,1,10,10,15,25);
        [u1,W]=trapezoidal(10,50,1,15,25,35,45);
        [u1,H]=trapezoidal(10,50,1,35,45,50,50);
        plot(u1,C,u1,W,u1,H)
        hold on
        plot(u1(F-9),C(F-9),'r*')
        plot(u1(F-9),W(F-9),'r*')
        plot(u1(F-9),H(F-9),'r*')
        plot(F,0.5,'b^')
            % Aquí se agrega la medida del sensor al título
            sensorT = 'Temperatura (°C)';
            title(sprintf('%s: %0.1f', sensorT, temperature), 'FontSize', 14);
        xlabel('Universe');
        ylabel('Membership Degree');
        legend('Cold','Warm','Hot','Input Evaluated');
        grid on
        text(u1(F-9),C(F-9),['\leftarrow' num2str(C(F-9))])
        text(u1(F-9),W(F-9),['\leftarrow' num2str(W(F-9))])
        text(u1(F-9),H(F-9),['\leftarrow' num2str(H(F-9))])
        text(F,0.5,['\leftarrow' num2str(F)])
        hold off
        n1=length(u1);

        %Distance
        subplot(3,1,2)
        [u2,S]=trapezoidal(0,200,1,0,0,25,75);
        [u2,M]=trapezoidal(0,200,1,25,75,125,175);
        [u2,L]=trapezoidal(0,200,1,125,175,200,200);
        plot(u2,S,u2,M,u2,L)
        hold on
        plot(u2(G),S(G),'r*')
        plot(u2(G),M(G),'r*')
        plot(u2(G),L(G),'r*')
        plot(G,0.5,'b^')
            % Aquí se agrega la medida del sensor al título
            sensorD = 'Distancia (cm)';
            title(sprintf('%s: %0.1f', sensorD, distance), 'FontSize', 14);
        xlabel('Universe');
        ylabel('Membership Degree');
        legend('Close','MEdium','Far','Input Evaluated');
        grid on
        text(u2(G),S(G),['\leftarrow' num2str(S(G))])
        text(u2(G),M(G),['\leftarrow' num2str(M(G))])
        text(u2(G),L(G),['\leftarrow' num2str(L(G))])
        text(G,0.5,['\leftarrow' num2str(G)])
        hold off
        n2=length(u2);
        
        %Speed
        subplot(3,1,3)
        [u3,OF]=triangular(0,4000,10,0,0,750);
        [u3,MIN]=triangular(0,4000,10,250,1000,1750);
        [u3,MED]=triangular(0,4000,10,1250,2000,2750);
        [u3,HIGH]=triangular(0,4000,10,2250,3000,3750);
        [u3,MAX]=triangular(0,4000,10,3250,4000,4000);
        plot(u3,OF,u3,MIN,u3,MED,u3,HIGH,u3,MAX)
        hold on
        title("Flag Position");
        xlabel('Universe');
        ylabel('Membership Degree');
        legend('Off','Min','Med','High','Max','Input Evaluated');
        grid on
        hold off
        n3=length(u3);
        
        %Rules
        %If S and C then OF
        R1=min(C(F-10),S(G));
        %If S and W then MIN
        R2=min(W(F-10),S(G));
        %If S and H then MED
        R3=min(H(F-10),S(G));
        
        %If M and C then MIN
        R4=min(C(F-10),M(G));
        %If M and W then MED
        R5=min(W(F-10),M(G));
        %If M and H then HIGH
        R6=min(H(F-10),M(G));
        
        %If L and C then MIN
        R7=min(C(F-10),L(G));
        %If L and W then HIGH
        R8=min(W(F-10),L(G));
        %If L and H then MAX
        R9=min(H(F-10),L(G));
        
        %Limits in outputs
        Ol=max([R1]);
        Minl=max([R2,R4,R7]);
        Medl=max([R3,R5]);
        Hl=max([R6,R8]);
        Maxl=max([R9]);
        
        %Limit lines for the outputs
        for i=1:n3
            Oll(i)=min([Ol,OF(i)]);
            Minll(i)=min([Minl,MIN(i)]);
            Medll(i)=min([Medl,MED(i)]);
            Hll(i)=min([Hl,HIGH(i)]);
            Maxll(i)=min([Maxl,MAX(i)]);
        end
        
        %Final Cutline
        for m=1:n3
            SpeedCut(m)=max([Oll(m),Minll(m),Medll(m),Hll(m),Maxll(m)]);
        end
        
        %Defuzzufy
        %Speed
        Z1=defuzz(u3,SpeedCut,'centroid')
        

        plot(u3,OF,u3,MIN,u3,MED,u3,HIGH,u3,MAX)
        hold on
        plot(u3,Oll,'-+','LineWidth',0.6)
        plot(u3,Minll,'-+','LineWidth',0.6)
        plot(u3,Medll,'-+','LineWidth',0.6)
        plot(u3,Hll,'-+','LineWidth',0.6)
        plot(u3,Maxll,'-+','LineWidth',0.6)
        plot(u3,SpeedCut,'LineWidth',3)
        plot(Z1,0,'r*')
            % Aquí se agrega la medida del flag
            sensorM = 'Speed (rpm)';
            title(sprintf('%s: %0.1f', sensorM, Z1), 'FontSize', 14);
        xlabel('Universe');
        ylabel('Membership Degree');
        legend('Of','Min','Med','High','Max','OF limit','MIN limit','MED limit','HIGH limit','MAX limit','Line Cut','Deffuzyfied value');
        grid on
        text(Z1,0.03,['\leftarrow' num2str(Z1)])
        hold off

                    % Agrega el título general a la figura
                    sgtitle('Mamdani Project <Error 404>', 'FontSize', 18, 'color', 'b');
                    % Lee la imagen que deseas agregar
                    img = imread('Error404.jpg');
                    % Muestra la imagen en la posición deseada
                    axes('position',[0.25 0.89 0.12 0.12]); % ajusta los valores a tu preferencia
                    imshow(img);
                    img2 = imread('Error404.jpg');
                    % Muestra la imagen en la posición deseada
                    axes('position',[0.65 0.89 0.12 0.12]); % ajusta los valores a tu preferencia
                    imshow(img2);
                    
        %Enviamos al arduino
        fprintf(s,'%s\n',num2r(Z1),'sync');

        % Pause to read data peristodically
        pause(1);
    end

catch exception
    if ~strcmp(exception.identifier, 'MATLAB:class:InvalidHandle')
        rethrow(exception);
    end
end

function closeSerial(s)
    fclose(s); % Close connection
    delete(s); % Delete connection object
    disp('Serial port connection error...');
end

