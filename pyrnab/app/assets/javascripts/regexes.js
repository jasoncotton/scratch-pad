(function () {
    "use strict";
    var app = angular.module('Pynab', []);
    app.controller('NavigationCtrl', ['$scope', '$window', function ($scope, $window) {
        $scope.path = {
            contains: function (targetPath) {
                if (String($window.location).match(targetPath)) {
                    return true;
                }
                return false;
            }
        };
    }]).
        controller('RegexCtrl', ['$scope', function ($scope) {
            $scope.search = {};
            $scope.hideRegex = {};

            $scope.runFilter = function (regexTest) {
                var i, cRegex, matches, namedMatches;
                i = regexes.regexes.length;
                while (i--) {
                    if (regexes.regexes[i].status === true) {
                        cRegex = regexes.regexes[i].regex.replace(/^\/|\/$/g, '');
                        namedMatches = cRegex.match(/\?P?\<(\w+)\>/g);
                        cRegex = cRegex.replace(/\?P?\<(\w+)\>/g, '');
                        matches = regexTest.match(cRegex);
                        $scope.matches = matches;
                        if (matches) {
                            console.log('found a match: ', cRegex, namedMatches, matches);
                            $scope.hideRegex[regexes.regexes[i].id] = false;
                        } else {
                            $scope.hideRegex[regexes.regexes[i].id] = true;
                        }
                    }
                }

            };

            $scope.$watch('search.regexTest', function (n, o) {
                if (n === o) {
                    console.log('initialized search.regex');
                } else {
                    if (n.length > 0) {
                        $scope.runFilter(n);
                    } else {
                        $scope.hideRegex = {};
                    }
                }
            });
        }]);

    app.controller('RegexEditCtrl', ['$scope', function ($scope) {
        $scope.record = {
            regex: regexModelValue,
            test: null
        };
        $scope.alerts = {
            success: false,
            failure: false
        };

        $scope.$watch('record.regex', function (n, o) {
            var cleanRegex;
            if (n === o) {
                $scope.record.test = '';
                $scope.alerts.success = false;
                $scope.alerts.failure = false;
            } else {
                if ($scope.record.test !== '') {
                    cleanRegex = String($scope.record.regex).replace(/^\/|\/$/g, '');
                    cleanRegex = cleanRegex.replace(/\&gt;/g, '>').replace(/\&lt;/g, '<').replace(/\&quot\;/g, '"');
                    cleanRegex = cleanRegex.replace(/\?P\<[^\>]+\>/g, '');
                    // console.log('cleanRegex: ', cleanRegex, $scope.record.test.match(RegExp(cleanRegex)));
                    $scope.matches = $scope.record.test.match(cleanRegex);
                    if ($scope.record.test.match(cleanRegex)) {
                        $scope.alerts.success = true;
                        $scope.alerts.failure = false;
                    } else {
                        $scope.alerts.failure = true;
                        $scope.alerts.success = false;
                    }
                } else {
                    $scope.alerts.success = false;
                    $scope.alerts.failure = false;
                }
            }
        });
    }]);
}).call(this);
