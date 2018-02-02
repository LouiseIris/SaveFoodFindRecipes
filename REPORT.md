Deze app laat gebruikers recepten opzoeken met ingrediënten die ze in huis hebben. Ze kunnen recepten bewaren, ingrediënten toevoegen aan hun boodschappenlijstje en punten verdienen als ze een ingredient gebruiken dat ze thuis al hebben.  
  
## Technisch Design  
class LoginViewController  
De app start met een login scherm en de registereer knop laat een popup verschijnen waar de gebruiker een nieuw account kan maken. Dit alles gebeurt via Firebase Authentication.   
  
class HomeViewController  
Wanneer de gebruiker is ingelogd, ziet hij het aantal punten dat hij al heeft verdiend en een knop om uit te loggen. De punten worden met een fetchPoints functie uit de “Points” database van Firebase gehaald. Via de tab bar onderin het scherm kan de gebruiker navigeren naar het zoekscherm, de bewaarde recepten en naar het  boodschappenlijstje.   
  
class SearchViewController  
In de search view controller kan de gebruiker een twee of drie verschillende ingrediënten invoeren. De search text fields bevatten een autocomplete suggestie lijst met alle mogelijke ingrediënten.   
  
class ResultsTableViewController  
Wanneer men op de zoekknop heeft geklikt verschijnt het resultaten scherm met recepten die alle ingrediënten bevatten waar op gezocht is. In de fetchResults functie worden de resultaten met de Yummly API opgehaald. Als de gebruiker een recept selecteert, wordt het id doorgegeven naar het detail scherm.   
  
class DetailViewController  
In het detail scherm in de fetchDetails functie wordt met het id een nieuwe API call gedaan. Een foto, de titel, alle ingrediënten en een link naar het originele recept zijn zichtbaar. De punten worden met de fetchPoints functie opgehaald. Rechtsboven in het scherm kan het recept opgeslagen worden naar de “Saved Recipes” database via Firebase. Door op een ingredient te klikken, krijgt men een popup te zien met de opties om dat ingredient toe te voegen aan het boodschappenlijstje. Dit ingredient wordt dan toegevoegd aan de “Grocery List” database op Firebase. Een andere optie is aangeven dat met het ingredient al thuis heeft wat ook een punt oplevert. Er wordt een punt toegevoegd en dit wordt veranderd in de “Points” database.  
  
class SavedRecipesTableViewController  
Het favorieten scherm bevat alle bewaarde recepten die de fetchSavedRecipes functie worden opgehaald uit Firebase. Wanneer men een recept selecteert, zal het detail scherm weer verschijnen. Door een swipe naar links of met het edit knopje rechtsboven kan een recept verwijderd worden uit het lijstje en uit Firebase.  
  
class GroceryListTableViewController  
Het scherm met het boodschappenlijstje laat alle ingrediënten zien die via het detailscherm van een recept zijn toegevoegd. Met de fetchGroceries functie wordt het lijstje van Firebase gehaald. Ook hier kan een ingredient verwijderd worden door middel van een swipe naar links of met het edit knopje rechtsboven.  
  
## Challenges en keuzes  
Het was meteen in het begin al lastig om goed in te schatten hoeveel tijd alles in beslag zou nemen. Zo had ik de eerste week niet veel aan mijn app gewerkt, waardoor ik de week erna een aantal dingen moest inhalen.  
Een moeilijk onderdeel was het gebruiken van de ingrediëntenlijst. Dit kwam doordat de lijst van Yummly niet een standaard JSON formaat had. Uiteindelijk is dit opgelost door letterlijk de eerste en laatste paar karakters eraf te knippen.  
Ook het ophalen van data uit Firebase was lastiger dan gedacht omdat ik niet alleen “kleinkinderen” wilde gebruiken, maar ook de “kinderen”.  
Voor de ingrediënten in het detail scherm wilde ik een variërend aantal buttons maken afhankelijk van het aantal ingrediënten. Uiteindelijk heb ik ervoor gekozen om een tableview te gebruiken, omdat dit makkelijker te implementeren was.  
Het scrollen in de tableviewcontrollers was ook een moeilijk onderdeel. De plaatjes bleven niet op de goede plek en ze veranderde van grootte. Dit is opgelost door custom cellen te gebruiken.  
Het allervervelendste was nog wel dat de ochtend van de deadline mijn app opeens crashte met een onduidelijke foutmelding. Na heel veel hulp is het uiteindelijk wel opgelost.  
Ik heb ervoor gekozen om het kunnen filteren van recepten en de suggestie op basis van bewaarde recepten achterwege te laten, omdat daar te kort tijd voor was.

  
