angular.module('openproject.workPackages.directives')

.directive('sortHeader', ['I18n', 'PathHelper', function(I18n, PathHelper){

  return {
    restrict: 'A',
    templateUrl: '/templates/work_packages/sort_header.html',
    scope: {
      query: '=',
      updateResults: '&'
    },
    link: function(scope, element, attributes) {
      scope.$watch('query.sortation', function(oldValue, newValue) {
        if (newValue !== oldValue) {
          scope.updateResults();
        }
      });

      scope.performSort = function(){
        targetSortation = scope.query.sortation.getTargetSortationOfHeader(scope.headerName);
        scope.query.setSortation(targetSortation);
        scope.currentSortDirection = scope.query.sortation.getDisplayedSortDirectionOfHeader(scope.headerName);
      };

      scope.headerName = attributes['headerName'];
      scope.headerTitle = attributes['headerTitle'];
      scope.sortable = attributes['sortable'];
      scope.currentSortDirection = scope.query.sortation.getDisplayedSortDirectionOfHeader(scope.headerName);
    }
  };
}]);