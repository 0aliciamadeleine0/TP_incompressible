function fig=visu_2D(x,y,mesh_info,buffer,...
                                EdgeColor_setting,visibility);

rank=mesh_info(:,1)+1;
for ii=1:length(rank)
   vertex1(rank(ii))=mesh_info(ii,2)+1;
   vertex2(rank(ii))=mesh_info(ii,3)+1;
   vertex3(rank(ii))=mesh_info(ii,4)+1;
end
fig=figure('Visible',visibility);
hold on;
for ii=1:length(rank)
   xplot(1:3,ii)=[x(vertex1(ii)) x(vertex2(ii)) x(vertex3(ii))];
   yplot(1:3,ii)=[y(vertex1(ii)) y(vertex2(ii)) y(vertex3(ii))];
   buff_plot(1:3,ii)=[buffer(vertex1(ii)) buffer(vertex2(ii)) ...
                      buffer(vertex3(ii))];
end
%patch(xplot,yplot,'cdata',buff_plot,'EdgeColor',EdgeColor_setting);
patch(xplot,yplot,buff_plot,'EdgeColor',EdgeColor_setting);
%
axis equal; axis tight;
colorbar
xlabel x;
ylabel y;



