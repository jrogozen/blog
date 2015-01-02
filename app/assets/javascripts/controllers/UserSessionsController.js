app.controller('UserSessionsController', ['$scope', '$auth', 'flash', 'User', function($scope, $auth, flash, User) {

  $scope.authenticate = function(provider) {
    $auth.authenticate(provider)
    .then(function(resp) {
    })
    .catch(function(resp) {
    });
  };
}]);