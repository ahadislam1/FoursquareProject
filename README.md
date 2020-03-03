# FoursquareProject

Foursquare app that allows you to check venues near you and from afar.

## Description

This app allows the usesr to browse venues located worldwide via the Foursquare API. Users have the ability to search a global map through the search view controller. The search vc contains a collection view as well as a tableview that displays an alternate view of the results from the search vc.  The collection and table views segue to a more descriptive view controller that contains more information about the selected venue.  It also allows users to see directions to the venue based on their current location and the venue's location.

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

![firstView](https://user-images.githubusercontent.com/55755297/75789298-7a05b400-5d37-11ea-82e9-7d112376e9e7.gif)

![detailView](https://user-images.githubusercontent.com/55755297/75789314-80942b80-5d37-11ea-87ab-2ed02f17b55f.gif)

![saveFromDetail](https://user-images.githubusercontent.com/55755297/75789322-82f68580-5d37-11ea-8333-7bb27d604c30.gif)

![finalView](https://user-images.githubusercontent.com/55755297/75789325-84c04900-5d37-11ea-98b0-cf34ec79cb4a.gif)

## Collaboraters

Maitree Bain

Tiffany Obi

Ahad Islam
