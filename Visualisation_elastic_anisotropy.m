    clear all;
    clc;
    %% Input
    % As input only the stiffness matrix in the correct Voigt Notation 4
    % and the
    % % division of azimuth angle are required. At the end this code 5
    % produces 4
    % % plots for the different material parameters. 6
    % % The azimuth angle is in the range of 0 to 2*pi, the elongation 7 angle goes
    % % from 0 to pi and the rotation angle psi is in the range of 0 to 2* 8 pi too.
    % % 9
    % Scheme for the stiffness matrix 10
    % 11
    % C = [ C11 C12 C13 sqrt(2)*C14 sqrt(2)*C15 12
    % sqrt(2)*C16;
    % C12 C22 C23 sqrt(2)*C24 sqrt(2)*C25 13
    % sqrt(2)*C26;
    % C13 C23 C33 sqrt(2)*C34 sqrt(2)*C35 14
    % sqrt(2)*C36;
    % sqrt(2)*C14 sqrt(2)*C24 sqrt(2)*C34 2*C44 2*C45 15
    % 2*C46;
    % sqrt(2)*C15 sqrt(2)*C25 sqrt(2)*C35 2*C45 2*C55 16
    % 2*C56;
    % sqrt(2)*C16 sqrt(2)*C26 sqrt(2)*C36 2*C46 2*C56 17
    % 2*C66 ];
    % 18
    % 19
    % % Division / Elements of the azimuth angle 20
    n = 70;
    % Division / Elements of the elongation angle 22
    m = n/2;
    % Division / Elements of the rotation angle 24
    o = 360;
    % Silicon in MPa ( Values are from [18]) 26


    %C = [ 13.3183 6.4327 6.4310 0 0 0;
    %    6.4327 13.3503 6.4323 0 0 0;
    %    6.4310 6.4323 13.3288 0 0 0;
    %    0 0 0 4.1630 0 0;
    %    0 0 0 0 4.1630 0;
    %    0 0 0 0 0 4.1630 ];
Files = dir()
for k=4:7

    z(:,:,k) = readmatrix(Files(k).name)
    %C = z(:,:,k)







    % Test materials in Voigt - Notation 34

    % 702 J. Nordmann et al.
    % EVA+Si in MPa (Values are from [32]) 36
    %C=[ 495.29 18.2 13.2 0 0 0; 37
    % 18.2 495.29 13.2 0 0 0; 38
    % 13.2 13.2 22.68 0 0 0; 39
    % 0 0 0 2*3.46 0 0; 40
    % 0 0 0 0 2*3.46 0; 41
    % 0 0 0 0 0 2*40000 ]/1000; 42
    % Cooper in MPa ( Values are from [18]) 44
    % C = [ 168 121.4 121.4 0 0 0; 45
    % 121.4 168 121.4 0 0 0; 46
    % 121.4 121.4 168 0 0 0; 47
    % 0 0 0 2*75.4 0 0; 48
    % 0 0 0 0 2*75.4 0; 49
    % 0 0 0 0 0 2*75.4 ]; 50
    % Gold in MPa ( Values are from [18]) 52
    % C = [ 185 158 158 0 0 0; 53
    % 158 185 158 0 0 0; 54
    % 158 158 185 0 0 0; 55
    % 0 0 0 2*39.7 0 0; 56
    % 0 0 0 0 2*39.7 0; 57
    % 0 0 0 0 0 2*39.7 ]; 58
    % Magnesium in MPa (Values are from [18]) 60
    % C = [ 56.49 23.16 18.10 0 0 0; 61
    % 23.16 56.49 18.10 0 0 0; 62
    % 18.10 18.10 58.73 0 0 0; 63
    % 0 0 0 2*16.81 0 0; 64
    % 0 0 0 0 2*16.81 0; 65
    % 0 0 0 0 0 (56.49 -23.16) ]; 66
    % Feldspar in MPa (Values are from [18]) 68
    % C = [ 61.9 43.4 36.8 -sqrt(2)*10 0 0; 69
    % 43.4 158.3 21.8 -sqrt(2)* 1.8 0 0; 70
    % 36.8 21.8 100.2 -sqrt(2)*12.1 0 0; 71
    % 0 0 -sqrt(2)*12.1 2*14.1 0 0; 72
    % 0 0 -sqrt(2)* 1.8 0 2*20.3 -2* 2.3; 73
    % 0 0 -sqrt(2)*10 0 -2* 2.3 2*36 ]; 74
    % Pyrite in MPa ( Values are from [18]) 76
    % C = [ 361.88 -47.96 -47.96 0 0 0; 77
    % -47.96 361.88 -47.96 0 0 0; 78
    % -47.96 -47.96 361.88 0 0 0; 79
    % 0 0 0 2*105.49 0 0; 80
    % 0 0 0 0 2*105.49 0; 81
    % 0 0 0 0 0 2*105.49 ]; 82
    % Weissblech in MPa (Values are from [18]) 84
    % C = [ 76.19 71.10 67.68 0 0 0; 85
    % 71.10 76.19 67.68 0 0 0; 86
    % 67.68 67.68 116.24 0 0 0; 87
    % 0 0 0 2*17.04 0 0; 88
    % 0 0 0 0 2*17.04 0; 89
    % 0 0 0 0 0 2*19.8 ]; 90
    % Isotropic testmaterial. Deriving the compliance matrix in line 151 92
    % must be deactivated by using this material
    % Material parameters are defined randomly. Just for debugging. 94
    % Solutions
    % are spheres with a radius of Y or nue. 95
    % Y = 100000; 96
    % nue = 0.25; 97
    % S = [ 1/Y, -nue/Y, -nue/Y, 0, 0, 0; 98
    % -nue/Y, 1/Y, -nue/Y, 0, 0, 0; 99
    % -nue/Y, -nue/Y, 1/Y, 0, 0, 0; 100
    % 0, 0, 0, 2*(1+nue)/Y/2, 0, 0; 101
    % 0, 0, 0, 0, 2*(1+nue)/Y/2, 0; 102
    % 0, 0, 0, 0, 0, 2*(1+nue)/Y 103
    % /2];

    %% Definition of the Memory 105
    % Angles 106
    phi = linspace (0, pi ,m);
    theta = linspace (0,2*pi ,n);
    psi = linspace (0,2*pi ,o);
    % Young "s modulus 110
    E = zeros (m,n);
    % Bulk modulus 112
    K = zeros (m,n);
    % Normal vector 114
    nn = zeros (3,o);
    % Poisson ratio 116
    nu = zeros (1,o);
    nu_max = zeros (m,n);
    nu_min = zeros (m,n);
    nu_avg = zeros (m,n);
    % Shear modulus 121
    G = zeros (1,o);
    G_max = zeros (m,n);
    G_min = zeros (m,n);
    G_avg = zeros (m,n);
    % Vectors for the cartesian coordinates 126
    x_E = zeros (m,n);
    y_E = zeros (m,n);
    z_E = zeros (m,n);
    x_K = zeros (m,n);
    y_K = zeros (m,n);
    z_K = zeros (m,n);
    x_nu_max = zeros (m,n);
    y_nu_max = zeros (m,n);
    z_nu_max = zeros (m,n);
    x_nu_min = zeros (m,n);
    y_nu_min = zeros (m,n);
    z_nu_min = zeros (m,n);
    x_nu_avg = zeros (m,n);
    y_nu_avg = zeros (m,n);
    z_nu_avg = zeros (m,n);
    x_G_max = zeros (m,n);
    y_G_max = zeros (m,n);
    z_G_max = zeros (m,n);
    x_G_min = zeros (m,n);
    y_G_min = zeros (m,n);
    z_G_min = zeros (m,n);
    x_G_avg = zeros (m,n);
    y_G_avg = zeros (m,n);
    z_G_avg = zeros (m,n);
    % Calculation of the compliance matrix 151
    S = C^-1;
    %% Calculation of Young "s and bulk modulus 153
    % Definition of the unit tensor in Voigt - notation 154
    U_V = [ 1;
        1;
        1;
        0;
        0;
        0 ];
    for i = 1:1:n
        for j = 1:1:m
            % Direction vector with radius r=1 163
            d =[ sin(phi(1,j))*cos(theta(1,i));
                sin(phi(1,j))*sin(theta(1,i));
                cos(phi(1,j)) ];
            % Calculation of the tensor D, d dyadic d 167
            D = d*d';
            % Transformation into Voigt - scheme 169
            d_V = [ D(1,1);
            D(2,2);
            D(3,3);
            sqrt(2)*D(2,3);
            sqrt(2)*D(1,3);
            sqrt(2)*D(1,2) ];
        % Calculation of the radius 176
        % Young "s modulus 177
        E(j,i) = 1/(d_V' *(S*d_V));
        % Bulk modulus 179
        K(j,i) = 1/(3*U_V' *(S*d_V));
        end
    end
    %% Calculation of Poisson ratio and shear modulus 183
    % Activate parallel processing 184
    poolobj = parpool();
    for i = 1:1:n
        for j = 1:1:m
            % Direction vector d with radius r=1 188
            d =[ sin(phi(1,j))*cos(theta(1,i));
                sin(phi(1,j))*sin(theta(1,i));
                cos(phi(1,j)) ];
            % Transformation into tensor D, d dyadic d 192
            D = d*d';
            % Transformation into Voigt - scheme 194
            d_V = [ D(1,1);
                D(2,2);
                D(3,3);
                sqrt(2)*D(2,3);
                sqrt(2)*D(1,3);
                sqrt(2)*D(1,2) ];
            % 201
            for k = 1:1:o
                % Normal vector with radius r=1 203
                nn(1,k) = -cos(phi(1,j))* cos(theta(1,i))*cos(psi(1,k)) + sin(theta(1,i))*sin(psi(1,k));
                nn(2,k) = -cos(phi(1,j))* sin(theta(1,i))*cos(psi(1,k)) - cos(theta(1,i))*sin(psi(1,k));
                nn(3,k) = sin(phi(1,j))* cos(psi(1,k));
                % Very small vector elements are set to exact zero
                for q = 1:1:3
                    if abs(nn(q,k)) <= 1e-6
                        nn(q,k) = 0;
                    else
                    end
                end
                % Transformation of the normal vector into tensor N, 216
                % nn dyadic nn 217
                N = nn(:,k)*nn(:,k)';
                % Transformation into Voigt - scheme 219
                n_V = [ N(1,1);
                    N(2,2);
                    N(3,3);
                    sqrt(2)*N(2,3);
                    sqrt(2)*N(1,3);
                    sqrt(2)*N(1,2) ];
                % Calculation of Tensor M 226
                M = sqrt (2) /2*(d*nn(:,k)'+nn(:,k)*d');
                % Transformation into Voigt - scheme 228
                m_V = [ M(1,1);
                    M(2,2);
                    M(3,3);
                    sqrt(2)*M(2,3);
                    sqrt(2)*M(1,3);
                    sqrt(2)*M(1,2) ];
                % Calculation of Poisson ratio for every psi 235
                nu(1,k) = -E(j,i)*d_V' *(S*n_V);

                % Calculation of shear modulus for every psi 237
                G(1,k) = 1/(2*m_V' *(S*m_V));
            end
            % Using of the criteria for Poisson ratio 240
            nu_max(j,i) = max(nu);
            nu_min(j,i) = min(nu);
            nu_avg(j,i) = sum(nu)/o;
            % Using of the criteria for shear modulus 244
            G_max(j,i) = max(G);
            G_min(j,i) = min(G);
            G_avg(j,i) = sum(G)/o;
        end
    end
    % Deactivate parallel processing 250
    delete (poolobj);
    %% Transformation of spherical coordiantes into cartesian coordinates 252
    for i = 1:1:n
        for j = 1:1:m
            % Young "s modulus 255
            x_E(j,i) = E(j,i)* sin(phi(1,j))* cos(theta(1,i));
            y_E(j,i) = E(j,i)* sin(phi(1,j))* sin(theta(1,i));
            z_E(j,i) = E(j,i)* cos(phi(1,j));
            % Bulk modulus 259
            x_K(j,i) = K(j,i)* sin(phi(1,j))* cos(theta(1,i));
            y_K(j,i) = K(j,i)* sin(phi(1,j))* sin(theta(1,i));
            z_K(j,i) = K(j,i)* cos(phi(1,j));
            % Poisson ratio 263
            % 1. Maximum / 2. Minimum / 3. Average 264
            x_nu_max(j,i) = nu_max(j,i)* sin(phi(1,j))*cos(theta(1,i));
            y_nu_max(j,i) = nu_max(j,i)* sin(phi(1,j))*sin(theta(1,i));
            z_nu_max(j,i) = nu_max(j,i)* cos(phi(1,j));
            x_nu_min(j,i) = nu_min(j,i)* sin(phi(1,j))*cos(theta(1,i));
            y_nu_min(j,i) = nu_min(j,i)* sin(phi(1,j))*sin(theta(1,i));
            z_nu_min(j,i) = nu_min(j,i)* cos(phi(1,j));
            x_nu_avg(j,i) = nu_avg(j,i)* sin(phi(1,j))*cos(theta(1,i));
            y_nu_avg(j,i) = nu_avg(j,i)* sin(phi(1,j))*sin(theta(1,i));
            z_nu_avg(j,i) = nu_avg(j,i)* cos(phi(1,j));
            % Shear modulus 274
            % 1. Maximum / 2. Minimum / 3. Average 275
            x_G_max(j,i) = G_max(j,i)* sin(phi(1,j))* cos(theta(1,i));
            y_G_max(j,i) = G_max(j,i)* sin(phi(1,j))* sin(theta(1,i));
            z_G_max(j,i) = G_max(j,i)* cos(phi(1,j));
            x_G_min(j,i) = G_min(j,i)* sin(phi(1,j))* cos(theta(1,i));
            y_G_min(j,i) = G_min(j,i)* sin(phi(1,j))* sin(theta(1,i));
            z_G_min(j,i) = G_min(j,i)* cos(phi(1,j));
            x_G_avg(j,i) = G_avg(j,i)* sin(phi(1,j))* cos(theta(1,i));
            y_G_avg(j,i) = G_avg(j,i)* sin(phi(1,j))* sin(theta(1,i));
            z_G_avg(j,i) = G_avg(j,i)* cos(phi(1,j));
        end
    end
    %% Plot of Young "s modulus and Bulk modulus 287
    % Colormap 288
    map1 = [0.3, 0, 0
        0.4, 0, 0
        0.5, 0, 0
        0.6, 0, 0
        0.8, 0, 0
        1.0, 0, 0];
    % Young "s modulus 295
    a = figure (1);
    set(a, "Units", "centimeters", "Position", [15, 10, 12, 10]);
    % Plot of the surface in cartesian coordiantes. The fourth argument 298
    % "E" respectively "K" is for the correct color. 299
    hold on
    surf (x_E , y_E , z_E , E,"FaceColor","interp","FaceAlpha" ,1.0, "LineWidth" , 0.01, "EdgeAlpha" ,0.2, "EdgeColor","w");
    hold off
    grid off
    box off
    set(gca ,...
        "XTick" ,[],...
        "YTick" ,[],...
        "ZTick" ,[],...
        "XColor","w" ,...
        "YColor","w" ,...
        "ZColor","w");
    colormap (map1);
    colormap ( flipud ( colormap ));
    c = colorbar ("eastoutside","Position" ,[0.87 0.27 .02 .5], "FontSize" ,10);
    c.Label.String = "{\it{Y}} [MPa]";
    c.Label. FontName = "Times New Roman";
    % Bulk modulus 318
    b = figure (2);
    set(b, "Units", "centimeters", "Position", [15, 10, 12, 10]);
    hold on
    surf (x_K , y_K , z_K , K,"FaceAlpha" ,1.0, "EdgeAlpha" ,0.2, "LineWidth" ,0.01, "EdgeColor","w");
    hold off
    grid off
    box off
    set(gca ,...
        "XTick" ,[],...
        "YTick" ,[],...
        "ZTick" ,[],...
        "XColor","w" ,...
        "YColor","w" ,...
        "ZColor","w");
    colormap (map1);
    h = colorbar ("eastoutside","Position" ,[0.8 0.3 .02 .4], "FontSize" ,10);
    set(h,"YTickLabel",cellstr( num2str(reshape(get(h,"YTick"),[],1),"%0.2 f")));
    h.Label.String = "{\it{K}} [MPa]";
    h.Label. FontName = "Times New Roman";
    %% Plot of Poisson ratio 339
    f = figure (3);
    set(f, "Units", "centimeters", "Position", [15, 10, 10, 8]);
    hold on
    h1 = surf (x_nu_max , y_nu_max , z_nu_max , nu_max ,"FaceColor","interp","FaceAlpha" ,1.0, "LineWidth" ,0.01, "EdgeAlpha" ,0.2, "EdgeColor","w") ;
    % h2 = surf(x_nu_min , y_nu_min , z_nu_min , nu_min ," FaceColor ","interp 345",...
    % "FaceAlpha " ,1.0,"LineWidth " ,0.01," EdgeAlpha " ,0.2," 346EdgeColor ","w");
    % h3 = surf(x_nu_avg , y_nu_avg , z_nu_avg , nu_avg ," FaceColor ","interp 347",...
    % "FaceAlpha " ,1.0,"LineWidth " ,0.01," EdgeAlpha " ,0.2," 348EdgeColor ","w");
    hold off
    grid off
    box off
    set(gca ,...
        "XTick" ,[],...
        "YTick" ,[],...
        "ZTick" ,[],...
        "XColor","w" ,...
        "YColor","w" ,...
        "ZColor","w");
    colormap (map1);
    g = colorbar ("southoutside","Position" ,[0.32 0.27 .4 .02], "FontSize" ,10);
    g.Label.String = "{\it{\nu}}_{max} [-]";
    g.Label. FontName = "Times New Roman";

    %% Plot of shear modulus 363
    t = figure (4);
    set(t, "Units", "centimeters", "Position", [15, 10, 10, 8]);
    hold on

    h4 = surf (x_G_max , y_G_max , z_G_max , G_max ,"FaceColor","interp" ,"FaceAlpha" ,1.0, "LineWidth" ,0.01, "EdgeAlpha" ,0.2, "EdgeColor","w") ;
    % h5 = surf(x_G_min , y_G_min , z_G_min , G_min ," FaceColor ","interp " ,... 370
    % "FaceAlpha " ,1.0,"LineWidth " ,0.01," EdgeAlpha " ,0.2," 371EdgeColor ","w");
    % h6 = surf(x_G_avg , y_G_avg , z_G_avg , G_avg ," FaceColor ","interp " ,... 372
    % "FaceAlpha " ,1.0,"LineWidth " ,0.01," EdgeAlpha " ,0.2," 373EdgeColor ","w");
    hold off
    grid off
    box off
    set(gca ,...
        "XTick" ,[],...
        "YTick" ,[],...
        "ZTick" ,[],...
        "XColor","w" ,...
        "YColor","w" ,...
        "ZColor","w");
    colormap (map1);
    d = colorbar ("southoutside","Position" ,[0.33 0.20 .4 .02], "FontSize",10);
    d.Label.String = "{\it{G}}_{max} [MPa]";
    d.Label. FontName = "Times New Roman";
end