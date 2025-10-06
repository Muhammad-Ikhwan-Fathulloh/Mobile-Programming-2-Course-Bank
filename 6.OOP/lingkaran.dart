class Lingkaran {
    double _phi = 3.14;
    late double _jari_jari;

    void setPhi(double value){
      if(value < 0){
        value *= -1;
      }
      _phi = value;
    }

    double getPhi(){
      return _phi;
    }

    void setJari_jari(double value){
      if(value < 0){
        value *= -1;
      }
      _jari_jari = value;
    }

    double getJari_jari(){
      return _jari_jari;
    }

    double getLuas() {
      return this._phi * _jari_jari * _jari_jari;
    }
}