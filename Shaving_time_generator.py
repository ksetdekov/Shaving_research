# генерирует список на 7 дней, чем бриться случайно
# электро или станок
# для электро - пена или без
from scipy.stats import bernoulli

p = 0.5  # p of T-handle
shaver_choice = bernoulli.rvs(p, size=7)
q = 0.5  # p of no foam
foam = bernoulli.rvs(q, size=7)
shavers = ['electric', 'T-handle']
foam_use = ['with foam', 'without foam']
for i in range(7):
    if shaver_choice[i] == 1:
        foam_res = foam_use[0]
    else:
        foam_res = foam_use[foam[i]]
    print('Day', i + 1, shavers[shaver_choice[i]], foam_res)
