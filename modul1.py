"""Dette modul indeholder funktionalitet til sådan og sådan"""


def f(n):
    """Funktionen f gør ikke så meget"""
    print('f ' + str(n))
    print('f ' + __name__)
    return n


def f2(n):
    """Dokumentation af f2 som 
    heller ikke gør noget fornuftigt. Bemærk multilinje docstring 
    """
    print('f2 ' + str(n))
    print('f2 ' + __name__)
    return n


if __name__ == '__main__':
    print('f2 ' + __name__)
    # Kør unittests her
    #
    #
#
# Kør fra prompt i samme dir som denne
# python
# import modul1 as m
# m.f(30)
#
# Køres modulet som script som fx herunder, så er __name__ __main__ og unittest køres
# python modul1.py
#
