locToCopy=which('fireworx_config')
localConfig='.\out.txt'

fid = fopen(localConfig);
data = fscanf(fid, '%c');
fclose(fid);
fidw = fopen(locToCopy, 'w');
fprintf(fidw, '%c', data);
fclose(fidw);
fireworx