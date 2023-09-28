clear; clc; close all;

disp('*****************************************************************');
disp('*********             In the name of god                *********');
disp('*********           Field and waves Project             *********');
disp('*********          The time domain of finite            *********'); 
disp('*********      difference in different environments     *********');
disp('*********   Developers: Reza Pourhasan, Hosein Davoudi  *********');
disp('*********        Conect me: +98 (915) 214 2041          *********');
disp('*****************************************************************');
fprintf('\n')

baseDirectory = 'C:\Users\r3z4\OneDrive\Desktop\Field and waves Project\';

while true
    fprintf('1) FDTD - 1D in Free Space\n');
    fprintf('2) FDTD - 2D in Free Space\n');
    fprintf('3) FDTD - 3D in Free Space\n');
    fprintf('4) FDTD - 2D in Dielectric Region\n');
    fprintf('5) FDTD - 3D in Dielectric Region\n');
    fprintf('6) FDTD - 3D in Magnetized Plasma\n');
    fprintf('Enter -1 for exit\n');
    disp('----------------------------------');
    menu = input('which one? ');

    switch menu
        case 1
            cd([baseDirectory 'FDTD - 1D in Free Space\']);
            % Run the main.m code
            try
                run('main.m');
                cd(baseDirectory)
            catch err
                disp(['Error running main.m: ' err.message]);
            end
    
    
        case 2
            cd([baseDirectory 'FDTD - 2D in Free Space\']);
            % Run the main.m code
            try
                run('main.m');
            catch err
                disp(['Error running main.m: ' err.message]);
            end
    
    
        case 3
            cd([baseDirectory 'FDTD - 3D in Free Space\']);
            % Run the main.m code
            try
                run('main.m');
            catch err
                disp(['Error running main.m: ' err.message]);
            end
    
    
        case 4
            cd([baseDirectory 'FDTD - 2D in Dielectric Region\']);
            % Run the main.m code
            try
                run('main.m');
            catch err
                disp(['Error running main.m: ' err.message]);
            end
    
    
        case 5
            cd([baseDirectory 'FDTD - 3D in Dielectric Region\']);
            % Run the main.m code
            try
                run('main.m');
            catch err
                disp(['Error running main.m: ' err.message]);
            end
    
    
        case 6
            cd([baseDirectory 'FDTD - 3D in Magnetized Plasma\']);
            % Run the main.m code
            try
                run('main.m');
            catch err
                disp(['Error running main.m: ' err.message]);
            end
        
        case -1
            disp('bye');
            break
    end
end