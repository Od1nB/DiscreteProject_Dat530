import requests
from datetime import datetime, time

##API SITE: https://api.kolumbus.no/restapi/swagger

getBusNr = "6"
def getActiveBuses(busNr):

    activeBuses = {"inbound": [], "outbound": []}

    lines = requests.get('https://api.kolumbus.no/api/lines')
    linesData = lines.json()
    busesLines = []
    for routes in linesData: 
        if routes.get('name') == busNr:
            routeId = routes.get('id')
            KOL = routes.get('kol_id') #1007 for rute 6
            busesLines.append(routes)
    #print(busesLines)
    busRoute = requests.get('https://api.kolumbus.no/api/lines/'+routeId+'/routes')
    busRouteData = busRoute.json()
    routeOut = busRouteData[0]
    routeIn =  busRouteData[1]
    #bjørn farmans gate = 03728acc-114a-4e52-a2ab-1a495e78befb //platforms/id/lines 


    activeRoutes = requests.get('https://api.kolumbus.no/api/journeys/active')
    activeRouteData = activeRoutes.json()

    for aRoute in activeRouteData:
        trip_id_check = aRoute.get('trip_id')[0:4]
        if trip_id_check == KOL: 
            if aRoute.get('name') == routeOut.get('destination_display'): 
                activeBuses.get('inbound').append(aRoute)
            elif aRoute.get('name') == routeIn.get('destination_display'):
                activeBuses.get('outbound').append(aRoute)

    return activeBuses['inbound'], activeBuses['outbound'], routeId
     

def getAllStops(tripID):
    platformsOnRoute = requests.get('https://api.kolumbus.no/api/lines/'+routeId+'/platforms')
    platformData = platformsOnRoute.json()
    platformIdList = []
    for platform in platformData:
        platformIdList.append(platform.get('id'))

    platformDepartures = {}
    ##For loop gjennom alle platformIDene
    for i in range(0,len(platformIdList)):
        platformTestId = platformIdList[i]
        platformDepartureRequest = requests.get('https://api.kolumbus.no/api/platforms/'+platformTestId+'/departures')
        pdrData = platformDepartureRequest.json()
        for platform in pdrData:
            if platform.get('trip_id') == tripID:
                platformDepartures[platform.get('order')] = {"platform_id":platformTestId, "platform_name": platform.get('platform_name'), "boarding": platform.get('boarding')}
                #platformDepartures.append(platform)
    sortedID = sorted(platformDepartures.items(), key=lambda item:item[0])
    sortedPlatform = {k: v for k, v in sortedID}
    print(sortedPlatform)
    return sortedPlatform
    
def getActiveBus(destinationName):
    activeVehicle = requests.get('https://api.kolumbus.no/api/vehicles/realtimehub')
    vehicleData = activeVehicle.json()
    activeVehicles = []
    for vehicle in vehicleData: 
        if vehicle.get('destination_display') == destinationName:
            activeVehicles.append(vehicle)
    return activeVehicles[0]

def allPlannedStops(busJourneyID):
    allStops = requests.get('https://api.kolumbus.no/api/journeys/'+busJourneyID+'/stoptimes')
    allStopsData = allStops.json()
    plannedStopList = {}
    traveltime = []
    for stop in allStopsData:
        plannedStopList[stop.get('order')] = {"platform_name": stop.get('platform_name')}

        ##used for calculating time between stops
        traveltime.append(stop.get('schedule_departure_time'))
        
        if stop.get('order') == 1: 
            startTime = stop.get('schedule_departure_time')
        if stop.get('order') == 43:
            endTime = stop.get('schedule_arrival_time')
            delay = stop.get('expected_arrival_time')

    stopTimeList = []
    totalTime = 0
    for i in range(0,len(traveltime)-1): 
        if traveltime[i+1] != None: 
            myTime = datetime.strptime(traveltime[i], "%Y-%m-%dT%H:%M:%S%z")
            nextStop = datetime.strptime(traveltime[i+1], "%Y-%m-%dT%H:%M:%S%z")
            timediff = nextStop - myTime
            stopTimeList.append(nextStop-myTime)
            totalTime += int(timediff.seconds)
    print("Average time between two stops: ", totalTime/len(stopTimeList))
    start_check = datetime.strptime(startTime, "%Y-%m-%dT%H:%M:%S%z")
    end_check = datetime.strptime(endTime, "%Y-%m-%dT%H:%M:%S%z")
    expectedTimeOfTrip = end_check - start_check
    sortedID = sorted(plannedStopList.items(), key=lambda item:item[0])
    sortedStops = {k: v for k, v in sortedID}
    return sortedStops, startTime, endTime, delay, expectedTimeOfTrip
    

""" busJourneyID = outbondBuses[-1].get('id')
destinationName = outbondBuses[-1].get('name')
tripID = outbondBuses[-1].get('trip_id')
activeBus = getActiveBus(destinationName)
sortedPlatformList = getAllStops(activeBus.get('journey_id'))
sortedStops = allPlannedStops(busJourneyID) """

def mainFunction(busNr):
    mainBusNr = busNr
    inboundBuses, outbondBuses, routeId = getActiveBuses(getBusNr)
    sandnesBus = len(outbondBuses)
    stvgBus = len(inboundBuses)
    busJourneyID = outbondBuses[-1].get('id')
    destinationName = outbondBuses[-1].get('name')

    mainSortedStops,startTime, endTime, delayTime, tripTime = allPlannedStops(busJourneyID)

    print("LineNr: ", mainBusNr, " - ", destinationName)
    print("Nr of buses towards Sandnes: ", sandnesBus)
    print("Nr of buses towards Stavanger: ", stvgBus)
    print("Start time of route: ", startTime)
    print("End time of route: ", endTime)
    print("Total travel time: ", tripTime)
    print("Expected arrival (+2t mangler) : ", delayTime)
    print("Stops on the route: ", mainSortedStops)

mainFunction(getBusNr)




