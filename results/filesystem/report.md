
### Harbor Performance Testing Report


| API | Avg | Min | Med | Max | P(90) | P(95) | Success Rate | Iterations Rate |
|-----|-----|-----|-----|-----|-------|-------|--------------|-----------------|
| get-catalog | 2.24s | 644.41ms | 2.25s | 2.99s | 2.55s | 2.64s | 100% | 42.51/s |
| list-artifact-tags | 244.78ms | 63.86ms | 201.63ms | 516.59ms | 454.89ms | 492.19ms | 100% | 375.73/s |
| list-artifacts | 1.53s | 675.13ms | 1.52s | 2.51s | 1.82s | 2.03s | 100% | 62.72/s |
| list-audit-logs | 2.44s | 479.71ms | 2.27s | 5.14s | 4.05s | 4.46s | 100% | 35.91/s |
| list-project-logs | 778.65ms | 204.45ms | 770.37ms | 1.3s | 1.02s | 1.07s | 100% | 118.54/s |
| list-project-members | 72.55ms | 17.48ms | 78.57ms | 158.21ms | 120.79ms | 125.06ms | 100% | 1242.98/s |
| list-projects | 646.81ms | 79.75ms | 206.03ms | 2.1s | 2.08s | 2.08s | 100% | 93.76/s |
| list-quotas | 305.86ms | 182.96ms | 305.26ms | 369.63ms | 366.33ms | 367.91ms | 100% | 275.54/s |
| list-repositories | 132.81ms | 27.84ms | 131.64ms | 229.52ms | 206.83ms | 214.65ms | 100% | 696.34/s |
| list-users | 24.05ms | 9.91ms | 23.77ms | 44.59ms | 33.27ms | 34.31ms | 100% | 2657.26/s |
| pull-artifacts-from-different-projects | 9.35s | 2.34s | 8.7s | 23.14s | 12.15s | 16.38s | 100% | 1.83/s |
| pull-artifacts-from-same-project | 19.49s | 768.89ms | 17.64s | 51.86s | 38.77s | 44.86s | 100% | 3.75/s |
| push-artifacts-to-different-projects | 10.62s | 3.11s | 11.32s | 20.43s | 17.21s | 18.1s | 100% | 3.44/s |
| push-artifacts-to-same-projects | 33.64s | 11.02s | 35.68s | 55.81s | 43.93s | 49.12s | 100% | 1.72/s |
| search-users | 49.3ms | 7.75ms | 42.91ms | 102.07ms | 97.04ms | 98.96ms | 100% | 1753.54/s |
