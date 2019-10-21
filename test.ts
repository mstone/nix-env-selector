export const getNixConfigList = (dirPath: string) =>
  node<NodeJS.ErrnoException, string[]>(done => {
    readdir(dirPath, done);
  }).map(files => files.filter(fileName => /.*\.nix/i.test(fileName)));
