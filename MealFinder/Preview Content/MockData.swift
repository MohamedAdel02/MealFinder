//
//  MockData.swift
//  MealFinder
//
//  Created by Mohamed Adel on 16/04/2026.
//

import Foundation


struct MockData {
    
    static var ingredients = [Ingredient(id: "1", name: "Chicken"), Ingredient(id: "2", name: "Salmon"), Ingredient(id: "3", name: "Beef"), Ingredient(id: "4", name: "Pork"), Ingredient(id: "5", name: "Avocado", isSelected: true), Ingredient(id: "9", name: "Apple Cider Vinegar"), Ingredient(id: "10", name: "Asparagus"), Ingredient(id: "11", name: "Aubergine"), Ingredient(id: "13", name: "Baby Plum Tomatoes"), Ingredient(id: "14", name: "Bacon"), Ingredient(id: "15", name: "Baking Powder", isSelected: true), Ingredient(id: "16", name: "Balsamic Vinegar"), Ingredient(id: "17", name: "Basil"), Ingredient(id: "18", name: "Basil Leaves"), Ingredient(id: "19", name: "Basmati Rice"), Ingredient(id: "20", name: "Bay Leaf"), Ingredient(id: "21", name: "Bay Leaves"), Ingredient(id: "23", name: "Beef Brisket"), Ingredient(id: "24", name: "Beef Fillet"), Ingredient(id: "25", name: "Beef Gravy"), Ingredient(id: "26", name: "Beef Stock"), Ingredient(id: "27", name: "Bicarbonate Of Soda"), Ingredient(id: "28", name: "Biryani Masala"), Ingredient(id: "29", name: "Black Pepper"), Ingredient(id: "30", name: "Black Treacle"), Ingredient(id: "31", name: "Borlotti Beans")]
    
    
    static var meal = Meal(id: "1", name: "Chick-Fil-A Sandwich",
                           score: 3, category: "Chicken",
                           thumbnail: "https://www.themealdb.com/images/media/meals/sbx7n71587673021.jpg",
                           instructions: "Wrap the chicken loosely between plastic wrap and pound gently with the flat side of a meat tenderizer until about 1/2 inch thick all around.\r\nCut into two pieces, as even as possible.\r\nMarinate in the pickle juice for 30 minutes to one hour (add a teaspoon of Tabasco sauce now for a spicy sandwich).\r\nBeat the egg with the milk in a bowl.\r\nCombine the flour, sugar, and spices in another bowl.\r\nDip the chicken pieces each into the egg on both sides, then coat in flour on both sides.\r\nHeat the oil in a skillet (1/2 inch deep) to about 345-350.\r\nFry each cutlet for 2 minutes on each side, or until golden and cooked through.\r\nBlot on paper and serve on toasted buns with pickle slices.",
                           ingredients: [Meal.Ingredient(name: "Chicken Breast", measure: "1"),
                                         Meal.Ingredient(name: "Milk", measure: "1/4 cup"),
                                         Meal.Ingredient(name: "Flour", measure: "1/2 cup")])
    
 
}
