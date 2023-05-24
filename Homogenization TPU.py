

# -*- coding: utf-8 -*-
"""
Created on Wed Oct 27 13:31:49 2021

@author: 15146
"""


import os
import json       # Native Anaconda Library
from subprocess import Popen, PIPE, STDOUT
import numpy as np

# Dictionary of all the volumetric lattice types present within nTop
dict_volumetric_types = {
    0: "Gyroid", 1: "Shwarz", 2: "Diamond",
    3: "Lidinoid", 4: "SplitP", 5: "Neovius"
    }


Rule = [0,1,2,4,5]
iteration = 1
resultats = [] 
thickness = np.arange(0.06,0.11,0.01)


for x in Rule:

# Boucle For pour passer les differents types de cellule unitaire

    for t in thickness:
        
        #young11 = 1e+8
        Cellsize = [5,5,5]
        
        
    # Boucle while pour passer les differentes valeurs de la taille de la cellule unitaire
        while      Cellsize >= [2,2,2]: 
            
            # ouverture et lecture des valeurs inscrite sur le Json
            filename = 'Input_Homo.json'
            with open(filename,'r') as file:
                data = json.load(file)
            print(data)
        
            data["inputs"][0]["value"] = Cellsize
            data["inputs"][1]["value"] = t
            data["inputs"][2]["value"] = x
            print('New itteration')
            print('cellsize', Cellsize , 'mm')
            print('thickness', t, 'mm')
            print('Lattice Type: ', dict_volumetric_types[x])
            os.remove(filename)
           
            with open(filename, 'w') as f:
                json.dump(data, f, indent=4)
            
            
            #Récuperer une valeur du fichier .csv crée par nTop en output (Export material)
            #with open('Homogenization test material.csv', mode = 'r') as f:
                #csvreader = list(csv.reader(f))
            
            
            
            Current_Directory = os.path.dirname(os.path.realpath('__file__'))
            exePath = r"C:/Program Files/nTopology/nTopology/nTopCL.exe"
            ## Put together string that calls nTop with input and output JSON databases
            arguments = [exePath]
            arguments.append("-j Input_Homo.json -o Out_Homo.json Homogenization_TPU.ntop")
            arguments = " ".join(arguments)
            
            
            print('Starting calculations...')
            print('iteration n',iteration)
            print('')
            
            # run nTop
            print(arguments)
            
            
            p = Popen(arguments, shell=False, stdin=PIPE, stdout=PIPE, stderr=STDOUT, close_fds=True)
            for line in p.stdout:
                print(line.rstrip())
                
            
            # open output json and read displacement
            with open('Out_Homo.json') as json_file:
                dataout = json.load(json_file)
                #for p in dataout:
                    
                C11 = float(dataout[0]["components"][0]["value"]["string"])
                C12 = float(dataout[0]["components"][1]["value"]["string"])
                C44 = float(dataout[0]["components"][2]["value"]["string"])
                    #C11 = (p["value"]["string"])
                    #young11 = float(Young11)
                print('')
                print('C11: ', C11,'MPa ','C12: ', C12,'MPa ','C44: ', C44,'MPa')
                print('')
                print('')
            
            
                
            resultat = [[dict_volumetric_types[x]],[Cellsize[0]],[t],[C11],[C12],[C44]]
            
            resultats.append(resultat)
             
              
            #Decrease la ttice size by specified amount      
            a = [-0.5,-0.5,-0.5]
                
            # adding vectors
            sum = []
            for i in range(len(a)):
                sum.append(a[i] + Cellsize[i])
             
            Cellsize = sum
            
            iteration +=1
        
        
        
    
    