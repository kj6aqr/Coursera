import graphlab

def simple_linear_regression(input_feature, output):
    # compute the sum of input_feature and output
    sum_x = sum(input_feature)
    sum_y = sum(output)
    n = len(input_feature)
    
    # compute the product of the output and the input_feature and its sum
    sum_xy = sum([i*j for i,j in zip(input_feature,output)])
    
    # compute the squared value of the input_feature and its sum
    sum_xx = sum([i*i for i in input_feature])
    
    # use the formula for the slope
    slope = (sum_xy-(sum_y*sum_x)/n) / (sum_xx-(sum_x*sum_x)/n)
    
    # use the formula for the intercept
    intercept = (sum_y/n - slope*sum_x/n)
    
    return (intercept, slope)


x=[1,2,3,4,5]
y=[i+1 for i in x]
print simple_linear_regression(x,y)

x=[1,2,3,4,5]
y=[2*i+4 for i in x]
print simple_linear_regression(x,y)
