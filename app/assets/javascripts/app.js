var app = angular.module('blog', [
  'ngRoute',
  'ngResource',
  'ng-token-auth',
  'ngCookies',
  'templates',
  'angular-flash.service',
  'angular-flash.flash-alert-directive',
  'ng-rails-csrf'
]);

app.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $routeProvider
  .when('/', {
    templateUrl: 'index.html',
    controller: 'PostsController',
    reloadOnSearch: false
  })
  .when('/posts/new', {
    templateUrl: "newPost.html",
    controller: 'PostController'
  })
  .when('/posts/:id', {
    templateUrl: "showPost.html",
    controller: 'PostController'
  })
  .when('/posts/:id/edit', {
    templateUrl: "editPost.html",
    controller: 'PostController'
  })
  .when('/sign_in', {
    templateUrl: "newUserSession.html",
    controller: "UserSessionsController"
  })
  .otherwise('/');

  $locationProvider.html5Mode(true);
}]);

// authentication

app.config(['$authProvider', function($authProvider) {
  $authProvider.configure({
    apiUrl: '/api',
    authProviderPaths: {
      github: '/auth/github',
      twitter: '/auth/twitter'
    }
  });
}]);

app.run(['$rootScope', '$location', 'flash', function($rootScope, $location, flash) {

  var adminRoute = function(route) {
    return _.str.startsWith(route, '/admin');
  }

  $rootScope.$on('auth:login-success', function(ev) {
    flash.success = 'Wooho! Successfully logged in.';
    $location.path('/');
  });

  $rootScope.$on('auth:login-error', function(ev) {
    flash.error = reason.errors[0];
  });

  $rootScope.$on('$routeChangeStart', function (event, next, current) {
    // if route requires auth and user is not logged in
    // if (!routeClean($location.url()) && !AuthenticationService.isLoggedIn()) {
    //   // redirect back to login
    //   $location.path('/login');
    // }
    if (adminRoute($location.url())) {
      console.log('we did it!');
    }
  });

}]);
