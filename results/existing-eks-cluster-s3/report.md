
### Harbor Performance Testing Report


| API | Avg | Min | Med | Max | P(90) | P(95) | Success Rate | Iterations Rate |
|-----|-----|-----|-----|-----|-------|-------|--------------|-----------------|
| get-catalog | 3.25s | 1.43s | 3.26s | 4.8s | 3.91s | 4.4s | 100% | 28.89/s |
| list-artifact-tags | 173.93ms | 34.44ms | 168.2ms | 376.37ms | 318.69ms | 341.9ms | 100% | 521.98/s |
| list-artifacts | 8.51s | 889.77ms | 9.09s | 18.64s | 11.03s | 15.99s | 74% | 10.72/s |
| list-audit-logs | 3.39s | 584.28ms | 3.07s | 6.91s | 5.87s | 6.69s | 100% | 24.86/s |
| list-project-logs | 1.2s | 499.15ms | 1.2s | 1.61s | 1.46s | 1.49s | 100% | 77.33/s |
| list-project-members | 77.09ms | 12.6ms | 80.36ms | 152.04ms | 125.54ms | 129.47ms | 100% | 1170.15/s |
| list-projects | 993.38ms | 82.19ms | 1s | 1.57s | 1.56s | 1.56s | 100% | 85.58/s |
| list-quotas | 272.64ms | 176.64ms | 280.89ms | 325.76ms | 308.15ms | 309.6ms | 100% | 304.41/s |
| list-repositories | 190.09ms | 54.15ms | 196.75ms | 381.74ms | 274.23ms | 283.11ms | 100% | 490.50/s |
| list-users | 24.97ms | 11.38ms | 24.52ms | 52.78ms | 32.83ms | 36.94ms | 100% | 2665.00/s |
| pull-artifacts-from-different-projects | 1.51s | 534.94ms | 1.37s | 3.61s | 2.24s | 2.64s | 100% | 1.35/s |
| pull-artifacts-from-same-project | 9.01s | 327.39ms | 7.67s | 24.32s | 19.99s | 20.93s | 100% | 7.76/s |
| push-artifacts-to-different-projects | 3.27s | 1.55s | 3.25s | 6.48s | 4.92s | 5.26s | 100% | 9.40/s |
| push-artifacts-to-same-projects | 35.54s | 5.45s | 39.94s | 65.5s | 47.85s | 53.13s | 100% | 1.92/s |
| search-users | 81.4ms | 6.49ms | 68.27ms | 169ms | 165.97ms | 166.85ms | 100% | 1152.34/s |
