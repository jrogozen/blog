app.controller('UserSessionsController', ['$scope', '$auth', 'flash', function($scope, $auth, flash) {
  $scope.authenticate = function(provider) {
    $auth.authenticate(provider)
    .then(function(resp) {
    })
    .catch(function(resp) {
    });
  };
}]);