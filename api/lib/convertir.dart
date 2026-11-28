/// MySQL devuelve los números como texto; estas funciones los convierten.
int aEntero(Object? valor) => int.parse('$valor');

double aDecimal(Object? valor) => double.parse('$valor');
