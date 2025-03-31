// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract learnStructs{
    struct Movie
    {
        uint id;
        string title;
        string director;
    }
    Movie movie = Movie(1, "Cool Movie", "Ibra");
    function setMovie () public  {
        movie.id = 2;
        movie.title = "Fantastic Movie";
        movie.director="Me";
    }
    function getMovie()public view returns (uint, string memory, string memory)   // we can return multiple values from a function
    {
         return(movie.id,movie.title , movie.director);
    }
    function getMovie2()public view returns (Movie memory)   // we can return multiple values from a function
    {
         return(movie);
    }
}