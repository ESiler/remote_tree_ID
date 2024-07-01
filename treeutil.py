## Show random tree :D
import folium
import pandas as pd

def show_random_tree(df):
    random_tree = df.sample(1) #get random tree
    #get tree info
    lat = random_tree['LAT'].iloc[0] #get location
    long = random_tree['LONG'].iloc[0]
    species_label = random_tree['COMMON_NAM'].item() + ' (' +random_tree['NAME'].item() + ')'
    
    #create map
    mp = folium.Map(location=[lat, long], zoom_start=22)
    #add tree marker
    folium.Marker(
        location=[lat, long],
        tooltip=species_label,
        popup=("happy little trees"),
        icon=folium.Icon(color="green"),
    ).add_to(mp)

    # Add Esri World Imagery tile layer
    folium.TileLayer(
        tiles='https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
        attr='Esri, DigitalGlobe, GeoEye, Earthstar Geographics, CNES/Airbus DS, USDA, USGS, AeroGRID, IGN, and the GIS User Community',
        name='Esri WorldImagery'
    ).add_to(mp)

    xoffset = .0005
    yoffset = xoffset*1.3

    folium.Rectangle(
        bounds=[[lat-xoffset, long-yoffset], [lat+xoffset, long+yoffset]],
        color='pink'
    ).add_to(mp)

    return(mp)
