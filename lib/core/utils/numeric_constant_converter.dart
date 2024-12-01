class NumericConstantConverter{
  static String convertClosureType(int closureType){
    switch(closureType){
      case 1: return 'Teljesítve';
      case 2: return 'Sofőr elutasítás';
      case 3: return 'Utas elutasítás';
      case 4: return 'Folyamatban';
      default: return 'Ismeretlen';
    }
  }
}