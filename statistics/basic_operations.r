# variables declarations
user_name = "ivo"
age = 22
student = TRUE
a = 1
b <- 2
3 -> c


print(user_name)
print(age)
print(student)

# data structures

## vector - for objects of one type
apple <- c("red", "green", "yellow")
print(apple)

## list - for objects of any types
list1 <- list(c(1, 2, 3), 21.3, sin)
print(list1)

## matrix - for 2 dimensional objects
M = matrix(c('a', 'b', 'c', 'd', 'e', 'f'), nrow=2, ncol=3, byrow=TRUE)
print(M)

## array - for N dimensions
a <- array(c('green', 'yellow'), dim=c(3, 3, 2))
print(a)

## factor - like a vector but stores unique elements too
apple_colors <- c('green','green','yellow','red','red','red','green')
factor_apple <- factor(apple_colors)
print(apple_colors)
print(factor_apple)

## data frame
BMI = data.frame(
  gender=c('Male', 'Female', 'Female'),
  height=c(188,170, 175),
  weight=c(90, 60, 50),
  age=c(20, 22, 23)
)
print(BMI)

fibonacci = function(n) {
  if(n <= 2)
    return (n);
 
   return (fibonacci(n - 1) + fibonacci(n - 2));
}
print(fibonacci(3))
