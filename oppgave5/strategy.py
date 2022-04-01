def player_strategy(n_battalions,n_fields):
    
    battalions=np.zeros(n_fields,dtype=int)
    
    battalions[0:3]=31
    battalions[3:5]=2
    battalions[5:]=3
    
    battalions=battalions[np.random.rand(n_fields).argsort()]
    assert sum(battalions)==n_battalions
    
    return battalions
a
