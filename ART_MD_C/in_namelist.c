
#define NP_I  ((int *)  (nameList[k].vPtr) + j)
#define NP_R  ((double *) (nameList[k].vPtr) + j)

int GetNameList (int argc, char **argv)
{
  int j, k, match, ok;
  char buff[80], *token;
  FILE *fp;
  char *status;

  // Try to catch error here
  if( argc < 2 ) {
    printf("Error: need one argument (input file name)\n");
    exit(1);
  }
  strcpy (buff, argv[1]);
  if ((fp = fopen (buff, "r")) == 0) {
    printf("Error reading file: %s\n", buff);
    exit(1);
  }
  for (k = 0; k < sizeof (nameList) / sizeof (NameList); k ++)
     nameList[k].vStatus = 0;
  ok = 1;
  while (1) {
    status = fgets (buff, 80, fp);
    if(status == NULL) {
      //printf("Get NULL when calling fgets\n");
    }
    if (feof (fp)) break;
    token = strtok (buff, " \t\n");
    if (! token) break;
    match = 0;
    for (k = 0; k < sizeof (nameList) / sizeof (NameList); k ++) {
      if (strcmp (token, nameList[k].vName) == 0) {
        match = 1;
        if (nameList[k].vStatus == 0) {
          nameList[k].vStatus = 1;
          for (j = 0; j < nameList[k].vLen; j ++) {
            token = strtok (NULL, ", \t\n");
            if (token) {
              switch (nameList[k].vType) {
                case N_I:
                  *NP_I = atol (token);
                  break;
                case N_R:
                  *NP_R = atof (token);
                  break;
              }
            } else {
              nameList[k].vStatus = 2;
              ok = 0;
            }
          }
          token = strtok (NULL, ", \t\n");
          if (token) {
            nameList[k].vStatus = 3;
            ok = 0;
          }
          break;
        } else {
          nameList[k].vStatus = 4;
          ok = 0;
        }
      }
    }
    if (! match) ok = 0;
  }
  fclose (fp);
  for (k = 0; k < sizeof (nameList) / sizeof (NameList); k ++) {
    if (nameList[k].vStatus != 1) ok = 0;
  }
  return (ok);
}

void PrintNameList (FILE *fp)
{
  int j, k;

  fprintf (fp, "#NameList -- data\n");
  for (k = 0; k < sizeof (nameList) / sizeof (NameList); k ++) {
    fprintf (fp, "#%s\t", nameList[k].vName);
    if (strlen (nameList[k].vName) < 8) fprintf (fp, "\t");
    if (nameList[k].vStatus > 0) {
      for (j = 0; j < nameList[k].vLen; j ++) {
        switch (nameList[k].vType) {
          case N_I:
            fprintf (fp, "%d ", *NP_I);
            break;
          case N_R:
            fprintf (fp, "%#g ", *NP_R);
            break;
        }
      }
    }
    switch (nameList[k].vStatus) {
      case 0:
      fprintf (fp, "** no data");
      break;
      case 1:
        break;
      case 2:
        fprintf (fp, "** missing data");
        break;
      case 3:
        fprintf (fp, "** extra data");
        break;
      case 4:
        fprintf (fp, "** multiply defined");
        break;
    }
    fprintf (fp, "\n");
  }
  fprintf (fp, "#----\n");
  fflush (fp);
}
