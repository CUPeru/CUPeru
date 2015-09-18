@cuperu = angular.module('cuperu', [])

@cuperu.config(['$routeProvider', ($routeProvider) -&gt;
  $routeProvider.
    otherwise({
      templateUrl: '../templates/home.slim',
      controller: 'HomeCtrl'
    }) 
])
