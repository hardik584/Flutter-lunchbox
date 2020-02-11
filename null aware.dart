https://medium.com/@thinkdigitalsoftware/null-aware-operators-in-dart-53ffb8ae80bb
This is an updated version of Seth Ladd’s blog post about Null-aware operators in Dart. Most of the content is unchanged with the exception of the examples provided at the end of the post, which help make the post easier to understand.
Null-aware operators in dart allow you to make computations based on whether or not a value is null. It’s shorthand for longer expressions.

??
Use ?? when you want to evaluate and return an expression IFF another expression resolves to null.
exp ?? otherExp
is similar to
((x) => x == null ? otherExp : x)(exp)
??=
Use ??= when you want to assign a value to an object IFF that object is null. Otherwise, return the object.
obj ??= value
is similar to
((x) => x == null ? obj = value : x)(obj)
?.
Use ?. when you want to call a method/getter on an object IFF that object is not null (otherwise, return null).
obj?.method()
is similar to
((x) => x == null ? null : x.method())(obj)
You can chain ?. calls, for example:
obj?.child?.child?.getter
If obj, or child1, or child2 are null, the entire expression returns null. Otherwise, getter is called and returned.
Update [4/19/2019] — Dart 2.3
?…
Dart 2.3 brings in a spread operator (…) and with it comes a new null aware operator, ?... !
Placing ... before an expression inside a collection literal unpacks the result of the expression and inserts its elements directly inside the new collection.
So now, these two are equivalent.
List numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
and
List lowerNumbers = [1, 2, 3, 4, 5];
List upperNumbers = [6, 7, 8, 9, 10];
List numbers = […lowerNumbers…upperNumbers];
To benefit from the new null aware operator, you can use it like this.
List lowerNumbers = [1, 2, 3, 4, 5];
List upperNumbers = [6, 7, 8, 9, 10];
List numbers = […lowerNumbers?…upperNumbers];
which is the equivalent to
List numbers = [];
numbers.addAll(lowerNumbers);
if(upperNumbers != null){
 numbers.addAll(upperNumbers);
}
