function isDigit(ch) {
    return ch >= "0" && ch <= "9";
}

function isInteger(n) {
    for (i = 0; i < n.length; i++)
        if (!isDigit(n.charAt(i)))
            return false;
    return true;
}

function disp_no(n) {
    if (n == "") return "";

    while (n.length % 3 != 0)
        n = "0" + n;

    v = "";
    k = 0;
    for (i = 0; i < n.length; i++) {
        v = v + n.charAt(i);

        k++;

        if (k % 3 == 0 && i < n.length - 1)
            v = v + ".";
    }

    k = 0;
    while (v.charAt(k) == "0" || v.charAt(k) == ".")
        k++;
    return v.substr(k);
}

function clean_no(n) {
    v = "";
    for (i = 0; i < n.length; i++)
        if (isDigit(n.charAt(i)))
            v = v + n.charAt(i);
    return v;
}

function check_rut(ruts, dv) {
    if (ruts == "" && dv == "") return true;

    rut = clean_no(ruts);

    if (!isInteger(rut))
        return false;

    suma = 0;
    mult = 2;

    for (i = rut.length - 1; i >= 0; i--) {
        suma = suma + rut.charAt(i) * mult;

        mult++;

        if (mult > 7)
            mult = 2;

    }

    //alert(suma%11);

    dvs = 11 - suma % 11;

    if (dvs == 10) dvs = "K";

    if (dvs == 11) dvs = "0";

    return dvs == dv;

}