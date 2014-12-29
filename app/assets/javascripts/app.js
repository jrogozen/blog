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
    apiUrl: 'http://localhost:3000/api',
    authProviderPaths: {
      github: '/auth/github',
      twitter: '/auth/twitter'
    }
  });
}]);

app.run(['$rootScope', '$location', function($rootScope, $location) {
  $rootScope.$on('auth:login-success', function() {
    // $location.path('/');
    console.log("success");
  });
  $rootScope.$on('auth:login-error', function(ev, reason) {
      alert('auth failed because', reason.errors[0]);
  });
  $rootScope.$on('auth:validation-success', function() {
    console.log('validated');
  });
  $rootScope.$on('auth:validation-error', function() {
    console.log('not validated');
  });
  $rootScope.$on('auth:invalid', function(ev, reason) {
    console.log(ev);
  });
}]);
