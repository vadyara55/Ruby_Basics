puts "Введите первую сторону треугольника"
a = gets.to_i
puts "Введите вторую сторону треугольника"
b = gets.to_i
puts "Введите третью сторону треугольника"
c = gets.to_i
cathetus_a, cathetus_b, hipotenuse = [a, b, c].sort

right_treangle = cathetus_a**2 + cathetus_b**2 == hipotenuse**2
isosceles_right_treangle = right_treangle && cathetus_a == cathetus_b
equilateral_treangle = cathetus_a == hipotenuse && cathetus_b == hipotenuse

if isosceles_right_treangle
  puts "Треугольник прямоугольный,равнобедренный"
elsif right_treangle
    puts "Треугольник прямоугольный"
elsif equilateral_treangle
  puts "Треугольник равносторонний"
else
  puts "Другой вид треугольника"
end
