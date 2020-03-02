# FoursquareProject

Foursquare app that allows you to check venues.

## Description

App allows the user to browse venues located worldwide via the Foursquare API. The user has the ability to search through the map through the search view controller. The search vc contains a collection view as well as a tableview that displays an alternate view of the results from the search vc.  The collection view and the table view segues to a more descriptive view controller that contains more information about the specified venue.  It also allows the user to see the directions based on the user's current location and the venue's location.

Users can save venues to user-specified collections.  They can create new collections or add to existing ones.  Users can delete selected venues from collections as well.

<img width="343" alt="Screen Shot 2020-03-02 at 5 03 56 PM" src="https://user-images.githubusercontent.com/55721710/75722240-d4573400-5ca7-11ea-8747-0a0d0c06bfb0.png"> <img width="343" alt="Screen Shot 2020-03-02 at 5 10 47 PM" src="https://user-images.githubusercontent.com/55721710/75722725-c7871000-5ca8-11ea-817b-7678b67d171d.png">

## Code Challenge

As part of the "extra credit", we wanted to add directions from our current location to our destination. In order to do so, we needed to inplement the code below.

<img width="500" alt="Screen Shot 2020-03-02 at 5 24 14 PM" src="https://user-images.githubusercontent.com/55755297/75724523-93ade980-5cac-11ea-860a-a81bd454c0a3.png">

Without the delegate we wouldnt be able to see the "overlay" which is, in simplest terms. the line from pooint A to point B.

<img width="1075" alt="Screen Shot 2020-03-02 at 5 26 12 PM" src="https://user-images.githubusercontent.com/55755297/75724011-6f9dd880-5cab-11ea-9c01-494ae5a38001.png">

### Small Wins! 

While working on the directions, we noticed that everytime an anotation was selected or directions requested the "overlays"  would lay over eachother. (no pun intended). This bug would cause small errors and crashes. In order to solve that problem we used the code below which would refresh the map each time. 
<img width="560" alt="Screen Shot 2020-03-02 at 5 44 39 PM" src="https://user-images.githubusercontent.com/55755297/75724988-88a78900-5cad-11ea-9521-992ead008527.png">

## Gifs 

![detailView](https://user-images.githubusercontent.com/55755297/75726533-990d3300-5cb0-11ea-85cf-8b4ccf80389b.gif)

![saveFromDetail](https://user-images.githubusercontent.com/55755297/75726503-8abf1700-5cb0-11ea-803c-58ef076561b8.gif)

![finalView](https://user-images.githubusercontent.com/55755297/75726478-7ed35500-5cb0-11ea-89c1-f59a106be665.gif)

## Collaboraters

Maitree Bain

Tiffany Obi

Ahad Islam
