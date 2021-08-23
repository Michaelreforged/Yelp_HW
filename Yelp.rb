# Michael Cheung
# a resturuant looks like this
# res_data = {
#   id: INTEGER *MUST BE UNIQUE,
#   name: STRING,
#   location: {
#     city: STRING,
#     state: STRING,
#   },
#   delivery: BOOLEAN,
#   days_open: STRING *DAYS SEPERATED BY COMMAS(NO SPACES) ie 'mon,tue,wed',
#   likes: INTEGER,
#   dishes: ARRAY OF OBJECTS/HASHES
#     { name: STRING, price: FLOAT, ingredients: ARRAY OF STRINGS },
#   ],
#   reviews: ARRAY OF HASHES [
#     {user_id: INTEGER *id of user object, rating: INTEGER 0-5}
#   ]
# }

system "clear"
user1 = {
  id: 1,
  name: "Tony",
}
user2 = {
  id: 2,
  name: "Sally",
}
res1 = {
  id: 1,
  name: "Spicy Thai",
  location: {
    city: "SLC",
    state: "UT",
  },
  delivery: true,
  days_open: "mon,tues,wed,thur,fri,sat,sun",
  likes: 1000,
  dishes: [
    { name: "Pad Thai", price: 10.25, ingredients: ["noddles", "peppers"] },
    { name: "Drunken Noodle", price: 9.25, ingredients: ["noddles", "chicken"] },
  ],
  reviews: [
    { user_id: 1, rating: 5 },
    { user_id: 2, rating: 3 },
  ],
}
res2 = {
  id: 2,
  name: "Albertos",
  location: {
    city: "SLC",
    state: "UT",
  },
  delivery: false,
  days_open: "mon,tues,wed,thur,fri,sat",
  likes: 500,
  dishes: [
    { name: "Tacos", price: 8.25, ingredients: ["tortilla", "carne"] },
    { name: "Quesidalla", price: 9.25, ingredients: ["tortilla", "cheese"] },
  ],
  reviews: [
    { user_id: 1, id: "Tony", rating: 2 },
    { user_id: 2, id: "Sally", rating: 4 },
  ],
}

@user = [
  user1,
  user2
]

@res = [
   res1,
   res2
]

## Start of assignment

u1name = user1[:name] # goes into user1 and pulls the key associated with name for user1
puts "User 1 name #{u1name}"
puts

## going from res2 into user1

@u1id_from_res2 = res2[:reviews][0][:user_id]

def res2_loop_for_u1id
  x = 0
  while x <= @user.length - 1

    if @user[x][:id] = @u1id_from_res2
      @uname_from_res2 = @user[x][:name]
      return  
    else 
    end 
    x = x + 1
  end
end
res2_loop_for_u1id

puts "Res2 User_id 1 name #{@uname_from_res2}"
puts

# access res1 reviews
puts "Res1 Reviews #{res1[:reviews]}"
puts

# what does this output res1[:dishes]
puts "Res1 dish output  #{res1[:dishes]}"
puts

# print out just the name of res1 dishes (each loop)
res1_dish = res1[:dishes].each do |x|
  puts "dish name #{x[:name]}"
end 
puts

# print out just the name of res1 dishes along with ingredients (nested each loop)
# res1[:dishes][ingredient]
res1_dish = res1[:dishes].each do |items|
  puts "#{items[:name]} has : \n"
  ingred = items[:ingredients].each do |y|
    puts "#{y}"
  end 
end 
puts 
# create a function that takes a user and return a string with the users name and id
def user_info(chosen_user)

  puts "chosen parameter #{chosen_user}"
  puts "#{chosen_user[:name]} ID: #{chosen_user[:id]}"
  
end 

user_info(user1)
puts
user_info(user2)
puts
# create a method that takes a res and returns the menu of that res

def res_menu(chosen_res)
    puts "#{chosen_res[:name]}"
    puts "Menus"
    index = @res.find_index(chosen_res)
    res_dish = @res[index][:dishes].each do |items|
      puts "#{items[:name]} has : \n"
      ingred = items[:ingredients].each do |y|
        puts "#{y}"
      end 
    end 
end

res_menu(res1)
puts
res_menu(res2)
puts 
# create that takes a res and returns average review


def res_review(chosen_res)
  puts "#{chosen_res[:name]}"
  puts "AVG reveiw"
  index_for_res = @res.find_index(chosen_res)
  @arr = []
  @res[index_for_res][:reviews].each do |rev, index_num|
    @arr.push(rev[:rating])
  end

  avg = @arr.sum / @arr.length
  puts "#{avg}"
  
end

res_review(res2)

# create an array of restaurants and do CRUD actions

def create_res
    puts "Please enter new res:"
    puts
    new_res = gets.chomp.strip
    @res.push(new_res)
end

def create_res_without_input(new_res)
  puts "Please enter new res:"
  puts
  @res.push(new_res)
end

def print_res
  num = 1
  puts "Res:"
  puts
  @res.each do |name|
    puts "#{name[:id]}. #{name[:name]}\nLocation: #{name[:location][:city]}, #{name[:location][:state]}\nDoes Delivery: #{name[:delivery]}\nDays Open: #{name[:days_open].upcase}\nLikes Count: #{name[:likes]}\nMenu:"
    res_dish = name[:dishes].each_with_index do |items, dish_num|
      puts "  #{dish_num+1}. #{items[:name]} has : \n"
      ingred = items[:ingredients].each do |y|
        puts "    #{y}"
      end 
    end 
    puts "Reviews:"
    res_rev = name[:reviews].each do |reviewer|
      puts "  #{reviewer[:user_id]}. #{reviewer[:id]}: #{reviewer[:rating]} Stars"
    end 
    puts

  end
end

def delete_res
  puts "Type the number of the res to delete:"
  puts 
  print_res
  goingaway = goingaway.to_i - 1

  if goingaway >= @res.length 
    puts "Invalid Input!"
    gets
    system "clear"
    delete_res
  else

  end
  @res.delete_at(goingaway)
  system "clear"
  puts "Updated res"
  print_ress
end
  
def edit_res
  puts "Type the number of the res to edit:"
  puts
  print_ress
  choice = gets.chomp.to_i
  choice = choice - 1
  if choice >= @res.length
    puts "Not a valid res"
    edit_res
  else
    puts "Please type new name"
    @res[choice] = gets.chomp
  end
  system "clear"
  print_ress
end

print_res

# a simple that takes a restaurants and adds to your array

def create_res_everything(new_res,res_name,res_city,res_state,res_del_status,res_days_open,res_likes,res_food_name,res_food_price,res_food_ingred_1,res_food_ingred_2,res_revi_uid,res_revi_id,res_revi_rating) # if we were taking user input there would be less variables and would have loops in the code to take in user input and add the data in, 
  @res.push(new_res)
  index = @res.length - 1
  @res[index] = {
  id: @res.length,
  name: res_name,
  location: {
    city: res_city,
    state: res_state,
  },
  delivery: res_del_status,
  days_open: res_days_open,
  likes: res_likes,
  dishes: [
    { name: res_food_name, price: res_food_price, ingredients: [res_food_ingred_1, res_food_ingred_2] }
  ],
  reviews: [
    { user_id: res_revi_id, id: res_revi_uid, rating: res_revi_rating }
  ]
}
end
create_res_everything("res3","Lard Lad Donuts","Springfield","Some State in the US","Yes","MON,TUES,WED,THUR,FRI,SUN,","5000","Donuts", 5.50 ,"Flour(Self-Raising)","Buttermilk", 3,"Homer S", 5)
print_res

#      a simple that takes restaurants and updates that to your array
# loop through your restaurants and return those with likes > 500 (select/filter)
# I want to think of ideas simple/hard and through them in slack

