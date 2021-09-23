
### Harbor Performance Testing Report


| API | Avg | Min | Med | Max | P(90) | P(95) | Success Rate | Iterations Rate |
|-----|-----|-----|-----|-----|-------|-------|--------------|-----------------|
| get-catalog | 2.27s | 1.17s | 2.3s | 3.4s | 2.96s | 3.04s | 100% | 40.27/s |
| list-artifact-tags | 203.95ms | 47.48ms | 207.69ms | 424.42ms | 373.64ms | 394.51ms | 100% | 449.05/s |
| list-artifacts | 1.58s | 599.06ms | 1.6s | 2.57s | 1.71s | 1.8s | 100% | 60.76/s |
| list-audit-logs | 2.39s | 259.71ms | 2.05s | 5.15s | 4.36s | 4.78s | 100% | 37.06/s |
| list-project-logs | 770.15ms | 321.25ms | 802.3ms | 987.27ms | 919.33ms | 934.46ms | 100% | 120.07/s |
| list-project-members | 88.29ms | 16.79ms | 80.43ms | 169.71ms | 158.04ms | 160.12ms | 100% | 1045.10/s |
| list-projects | 731.97ms | 118.09ms | 516.72ms | 1.64s | 1.58s | 1.59s | 100% | 113.00/s |
| list-quotas | 300.9ms | 173.84ms | 307.46ms | 367.89ms | 344.96ms | 363.5ms | 100% | 278.57/s |
| list-repositories | 136.56ms | 41.49ms | 139.04ms | 263.48ms | 217.05ms | 228.87ms | 100% | 682.97/s |
| list-users | 25.79ms | 14.34ms | 25.56ms | 51.78ms | 35.08ms | 37.36ms | 100% | 2419.51/s |
| pull-artifacts-from-different-projects | 6.57s | 877.43ms | 6.54s | 16.26s | 10.38s | 11.68s | 100% | 0.86/s |
| pull-artifacts-from-same-project | 16.31s | 644.56ms | 13.99s | 43.26s | 32.34s | 37.66s | 100% | 4.33/s |
| push-artifacts-to-different-projects | 4.11s | 1.99s | 3.89s | 7.71s | 5.7s | 6.39s | 100% | 4.27/s |
| push-artifacts-to-same-projects | 40.69s | 6.51s | 49.67s | 56.24s | 52.54s | 52.87s | 100% | 1.43/s |
| search-users | 62.26ms | 7.47ms | 51.15ms | 121.6ms | 114.81ms | 117.53ms | 100% | 1395.99/s |
