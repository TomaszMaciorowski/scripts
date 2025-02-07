#!/usr/bin/python
import os
import shutil
import time

# Ścieżka do głównego katalogu
backup_dir = '/rpool1520/arch'

# Ustaw granicę czasową na 60 dni temu
cutoff_date = time.time() - 60 * 86400  # 60 dni w sekundach

# Pobierz wszystkie katalogi zaczynające się na 'b'
dirs = [os.path.join(backup_dir, d) for d in os.listdir(backup_dir) if os.path.isdir(os.path.join(backup_dir, d)) and d.startswith('b')]

# Sortuj katalogi według daty modyfikacji (od najnowszego do najstarszego)
dirs.sort(key=lambda x: os.path.getmtime(x), reverse=True)

# Zachowaj dwa najnowsze katalogi
dirs_to_check = dirs[2:]

# Usuń katalogi starsze niż 60 dni
for dir_path in dirs_to_check:
    if os.path.getmtime(dir_path) < cutoff_date:
##        shutil.rmtree(dir_path)
        print(f"Usunięto katalog: {dir_path}")
    else:
        print(f"Katalog {dir_path} jest nowszy niż 60 dni, nie usuwam.")
