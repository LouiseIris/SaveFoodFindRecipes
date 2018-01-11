# Project proposal

This recipes app will let the user search for recipes with the ingredients the user has at home.  
  
## Problem statement  
Some people have leftover ingredients at home and often it will be spoiled, because they don't know what to do with it.
To tackle the problem of food waste, this app will help people to use the leftover ingredients.  
The app is meant for people who can't think of a recipe for their ingredients and who want to be environmantally conscious.  
  
## Solution  
This app will let the user fill in the ingredients they have at home and then they will get several recipes they can make with that.  
<img src=https://github.com/LouiseIris/SaveFoodFindRecipes/blob/master/doc/schets.jpg width="1000">  
  
list of main features:  
* login MVP  
* fill in ingredients MVP  
* autocomplete ingredients search
* order found recipes with recipes that use the filled in ingredients the most on top 
* save recipe MVP  
* add ingredient to grocerylist MVP  
* list saved recipes MVP  
* list ingredients that need to be bought MVP  
* filter recipes by course, cuisine, allergies, preperation time MVP
* get points for ingredients that are not spilled
* leaderboard with most environmentally conscious persons
* daily recipe suggestion based on earlier used recipes
  
## Prerequisites  
#### Datasources:  
Yummly  
To do: leave out unneccesairy information  
link: https://developer.yummly.com/documentation  
  
#### External components:  
Firebase  
  
#### Similar apps:  
Recipes by Ingredients (https://itunes.apple.com/us/app/recipes-by-ingredients/id605509474?mt=8)  
This app is very userunfriendly. It is more like a web app in stead of a native app. I want to improve the way to fill in the ingredients by using autocomplete. This app doesn't remember the recipes the user has made, I want to give the user daily recipe suggestions based on often used ingredients or cuisines. This app is not focussed on stopping food waste. I want to give the user points for every ingredient that is not spilled.  
  
#### Hardest parts:  
Using the API  
Fill in the ingredients
