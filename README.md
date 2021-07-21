# iTunesSearch

![Main Page](https://user-images.githubusercontent.com/85978406/126442006-5b535544-d326-4eb4-b10e-1e236fc0e706.png)

 <br>

Design Pattern: MVVM <br>
Why MVVM? <br>
Given that the requirements mentioned that app should be scalable as well as iTunes API returns feature-rich responses <br>
Application can be expanded to cater various powerful modules. <br>
Pros of MVVM: <br>
- Decoupled logics from View hence more testable
- Good for Large Scale Project <br>
Cons <br>
- Overkill for small projects
- Reusability of View Models and Views can be difficult<br>
<br>
UI: Storyboard, XIB and Autolayout <br>
Dependencies: SDWebImage <br>
Presistent Store: Core Data <br>
XCode Version: 11.7 <br>
CocoaPods Version: 1.10.1 <br>
<br>

Features<br>
<br>
Movie List Screen <br>

![Main Page](https://user-images.githubusercontent.com/85978406/126442006-5b535544-d326-4eb4-b10e-1e236fc0e706.png)

<br>
- Search Movies using iTunes API
- Display Movie Title, Artist, Genre, Track and Rental Price
- Display Image using SDWebImage with Placeholder
- Save Track Id in Core Data upon DidSelect to store Last Visit
- Add to Favorites Functionality 
<br> App stores track Id in Core Data for Favorites Referencing
- Load Default API when search bar is cleared
- View Movie Details

Movie Details <br>
<br>
![Movie Details](https://user-images.githubusercontent.com/85978406/126442280-43f7a79e-8acf-45cf-8877-32046ef1316d.png)
<br>
- Display Movie Title, Track, Rental Price, Long Description with auto sizing cell, Genre, Release Date
- Favorite Button

<br>

Favorite List <br>
<br>
![Favorite List](https://user-images.githubusercontent.com/85978406/126442471-dd4953bd-2f42-4528-b2b7-11b50cef9aa9.png)
<br>
- Fetch Track Ids from Core Data then call iTunes lookup API.
<br> App fetches all Ids in Core Data then will be appended in the URL
- Slide to Delete Favorite functionality. 
<br> Deletes record in Core Data
<br>

Favorite Movie Details <br>
<br>
![Favorite Movie Details](https://user-images.githubusercontent.com/85978406/126443593-f0eb3fcc-53c2-4963-871f-7a9d776b5aa0.png)
<br>

- Reused View From Movie Details
- Favorite Icon changed to Delete Icon where view pops upon confirmation of deletion





