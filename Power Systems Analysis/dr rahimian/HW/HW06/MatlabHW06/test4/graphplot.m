% Creates a Graph plot of interconnected buses...
% Praviraj PG, May-10-2020
function graphplot(V,Del,fb,tb,Pij,Qij)
% Create Edge Labels...
EdlbP = Pij(sub2ind(size(Pij), fb,tb));
EdlbQ = Qij(sub2ind(size(Pij), fb,tb));
kP = strcat(num2str(round(EdlbP,1)),' MW, ');
kQ = strcat(num2str(round(EdlbQ,1)),' MVAR');
kPQ = string(strcat(kP, kQ));
% Create Node Labels..
nb = 1:length(V);
kn = strcat(num2str(nb'),' = ') ;
kV = strcat(num2str(round(V,3)), 'V,');
kD = strcat(num2str(round(Del,2)),'°');
kVD = string(strcat(kn, kV, kD));
% Create a Directed Graph..
G = digraph(fb,tb);
G.Edges.Power = kPQ;
G.Nodes.Size = kVD;
% Plot
p = plot(G,'EdgeLabel',G.Edges.Power, 'NodeLabel',G.Nodes.Size,'Layout','force');
set(p, 'LineWidth', 2, 'MarkerSize', 7, 'Marker', 's', ...
    'NodeColor', 'm', 'NodeFontWeight', 'bold', 'NodeLabelColor','r');
