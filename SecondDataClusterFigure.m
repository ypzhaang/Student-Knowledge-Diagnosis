%% figure SencondData
x = [1,4];
y = [1,4];
sim = [1,0.55,0.55,0.75;0.55,1,0.50,0.58;0.55,0.50,1,0.75;0.75,0.58,0.75,1];
imagesc(sim);
colorbar;
colorbar('Direction','reverse');
colormap(parula(5));