import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:tcc_ceclimar/models/animal_response.dart';

class AnimalService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<AnimalResponse> _animals = [];

    List<Map<String, dynamic>> animalsCreate = [
    {'id': 1, 'popularName': 'tartaruga-cabeçuda', 'scientificName': 'Caretta caretta', 'genus': 'Caretta', 'species': 'caretta', 'family': 'Cheloniidae', 'order': 'Testudines', 'classe': 'Reptilia', 'quantity': 597, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 2, 'popularName': 'lobo-marinho-sul-americano', 'scientificName': 'Arctocephalus australis', 'genus': 'Arctocephalus', 'species': 'australis', 'family': 'Otariidae', 'order': 'Carnivora', 'classe': 'Mammalia', 'quantity': 397, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 3, 'popularName': 'pinguim-de-magalhães', 'scientificName': 'Spheniscus magellanicus', 'genus': 'Spheniscus', 'species': 'magellanicus', 'family': 'Spheniscidae', 'order': 'Sphenisciformes', 'classe': 'Aves', 'quantity': 465, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 4, 'popularName': 'toninha', 'scientificName': 'Pontoporia blainvillei', 'genus': 'Pontoporia', 'species': 'blainvillei', 'family': 'Pontoporiidae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 280, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 5, 'popularName': 'tartaruga-verde', 'scientificName': 'Chelonia mydas', 'genus': 'Chelonia', 'species': 'mydas', 'family': 'Cheloniidae', 'order': 'Testudines', 'classe': 'Reptilia', 'quantity': 144, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 6, 'popularName': 'leão-marinho-do-sul', 'scientificName': 'Otaria flavescens', 'genus': 'Otaria', 'species': 'flavescens', 'family': 'Otariidae', 'order': 'Carnivora', 'classe': 'Mammalia', 'quantity': 113, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 7, 'popularName': 'tartaruga-de-couro', 'scientificName': 'Dermochelys coriacea', 'genus': 'Dermochelys', 'species': 'coriacea', 'family': 'Dermochelyidae', 'order': 'Testudines', 'classe': 'Reptilia', 'quantity': 54, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 8, 'popularName': 'bobo-pequeno', 'scientificName': 'Puffinus puffinus', 'genus': 'Puffinus', 'species': 'puffinus', 'family': 'Procellariidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 43, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 9, 'popularName': 'tartaruga-oliva', 'scientificName': 'Lepidochelys olivacea', 'genus': 'Lepidochelys', 'species': 'olivacea', 'family': 'Cheloniidae', 'order': 'Testudines', 'classe': 'Reptilia', 'quantity': 32, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 10, 'popularName': 'albatroz-de-nariz-amarelo', 'scientificName': 'Thalassarche chlororhynchos', 'genus': 'Thalassarche', 'species': 'chlororhynchos', 'family': 'Diomedeidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 30, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 11, 'popularName': 'baleia-jubarte', 'scientificName': 'Megaptera novaeangliae', 'genus': 'Megaptera', 'species': 'novaeangliae', 'family': 'Balaenopteridae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 52, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 12, 'popularName': 'gambá-de-orelha-branca', 'scientificName': 'Didelphis albiventris', 'genus': 'Didelphis', 'species': 'albiventris', 'family': 'Didelphidae', 'order': 'Didelphimorphia', 'classe': 'Mammalia', 'quantity': 31, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 13, 'popularName': 'pardela-preta', 'scientificName': 'Procellaria aequinoctialis', 'genus': 'Procellaria', 'species': 'aequinoctialis', 'family': 'Procellariidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 27, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 14, 'popularName': 'baleia-franca-austral', 'scientificName': 'Eubalaena australis', 'genus': 'Eubalaena', 'species': 'australis', 'family': 'Balaenidae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 18, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 15, 'popularName': 'bobo-grande', 'scientificName': 'Calonectris borealis', 'genus': 'Calonectris', 'species': 'borealis', 'family': 'Procellariidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 10, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 16, 'popularName': 'gaivotão', 'scientificName': 'Larus dominicanus', 'genus': 'Larus', 'species': 'dominicanus', 'family': 'Laridae', 'order': 'Charadriiformes', 'classe': 'Aves', 'quantity': 8, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 17, 'popularName': 'biguá', 'scientificName': 'Nannopterum brasilianus', 'genus': 'Nannopterum', 'species': 'brasilianus', 'family': 'Phalacrocoracidae', 'order': 'Suliformes', 'classe': 'Aves', 'quantity': 10, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 18, 'popularName': 'boto-de-lahille', 'scientificName': 'Tursiops gephyreus', 'genus': 'Tursiops', 'species': 'gephyreus', 'family': 'Delphinidae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 24, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 19, 'popularName': 'pernilongo-de-costas-brancas', 'scientificName': 'Himantopus melanurus', 'genus': 'Himantopus', 'species': 'melanurus', 'family': 'Recurvirostridae', 'order': 'Charadriiformes', 'classe': 'Aves', 'quantity': 6, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 20, 'popularName': 'capivara', 'scientificName': 'Hydrochoerus hydrochaeris', 'genus': 'Hydrochoerus', 'species': 'hydrochaeris', 'family': 'Caviidae', 'order': 'Rodentia', 'classe': 'Mammalia', 'quantity': 8, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 21, 'popularName': 'bobo-grande-de-sobre-branco', 'scientificName': 'Puffinus gravis', 'genus': 'Puffinus', 'species': 'gravis', 'family': 'Procellariidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 12, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 22, 'popularName': 'cágado-de-barbelas', 'scientificName': 'Phrynops hilarii', 'genus': 'Phrynops', 'species': 'hilarii', 'family': 'Chelidae', 'order': 'Testudines', 'classe': 'Reptilia', 'quantity': 6, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 23, 'popularName': 'cachalote', 'scientificName': 'Physeter macrocephalus', 'genus': 'Physeter', 'species': 'macrocephalus', 'family': 'Physeteridae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 5, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 24, 'popularName': 'albatroz-de-sobrancelha', 'scientificName': 'Thalassarche melanophris', 'genus': 'Thalassarche', 'species': 'melanophris', 'family': 'Diomedeidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 6, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 25, 'popularName': 'tigre-d\'água', 'scientificName': 'Trachemys dorbigni', 'genus': 'Trachemys', 'species': 'dorbigni', 'family': 'Emydidae', 'order': 'Testudines', 'classe': 'Reptilia', 'quantity': 9, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 26, 'popularName': 'tartaruga-de-pente', 'scientificName': 'Eretmochelys imbricata', 'genus': 'Eretmochelys', 'species': 'imbricata', 'family': 'Cheloniidae', 'order': 'Testudines', 'classe': 'Reptilia', 'quantity': 5, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 27, 'popularName': 'falsa-orca', 'scientificName': 'Pseudorca crassidens', 'genus': 'Pseudorca', 'species': 'crassidens', 'family': 'Delphinidae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 3, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 28, 'popularName': 'golfinho-de-dentes-rugosos', 'scientificName': 'Steno bradanensis', 'genus': 'Steno', 'species': 'bradanensis', 'family': 'Delphinidae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 7, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 29, 'popularName': 'mandrião-parasítico', 'scientificName': 'Stercorarius parasiticus', 'genus': 'Stercorarius', 'species': 'parasiticus', 'family': 'Stercorariidae', 'order': 'Charadriiformes', 'classe': 'Aves', 'quantity': 3, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 30, 'popularName': 'golfinho-comum-de-bico-curto', 'scientificName': 'Delphinus delphis', 'genus': 'Delphinus', 'species': 'delphis', 'family': 'Delphinidae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 31, 'popularName': 'dragão-azul', 'scientificName': 'Glaucus atlanticus', 'genus': 'Glaucus', 'species': 'atlanticus', 'family': 'Glaucidae', 'order': 'Nudibranchia', 'classe': 'Gastropoda', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 32, 'popularName': 'piru-piru', 'scientificName': 'Haematopus palliatus', 'genus': 'Haematopus', 'species': 'palliatus', 'family': 'Haematopodidae', 'order': 'Charadriiformes', 'classe': 'Aves', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 33, 'popularName': 'petrel-gigante-do-norte', 'scientificName': 'Macronectes halli', 'genus': 'Macronectes', 'species': 'halli', 'family': 'Procellariidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 3, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 34, 'popularName': 'elefante-marinho-do-sul', 'scientificName': 'Mirounga leonina', 'genus': 'Mirounga', 'species': 'leonina', 'family': 'Phocidae', 'order': 'Carnivora', 'classe': 'Mammalia', 'quantity': 14, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 35, 'popularName': 'cação-rola-rola', 'scientificName': 'Rhizoprionodon lalandii', 'genus': 'Rhizoprionodon', 'species': 'lalandii', 'family': 'Carcharhinidae', 'order': 'Carcharhiniformes', 'classe': 'Chondrichthyes', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 36, 'popularName': 'tubarão-martelo-entalhado', 'scientificName': 'Sphyrna lewini', 'genus': 'Sphyrna', 'species': 'lewini', 'family': 'Sphyrnidae', 'order': 'Carcharhiniformes', 'classe': 'Chondrichthyes', 'quantity': 3, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 37, 'popularName': 'golfinho-nariz-de-garrafa', 'scientificName': 'Tursiops truncatus', 'genus': 'Tursiops', 'species': 'truncatus', 'family': 'Delphinidae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 3, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 38, 'popularName': 'cágado-negro', 'scientificName': 'Acanthochelys spixii', 'genus': 'Acanthochelys', 'species': 'spixii', 'family': 'Podocnemididae', 'order': 'Testudines', 'classe': 'Reptilia', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 39, 'popularName': 'asa-de-telha', 'scientificName': 'Agelaioides badius', 'genus': 'Agelaioides', 'species': 'badius', 'family': 'Fringillidae', 'order': 'Passeriformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 40, 'popularName': 'lobo-marinho-subantártico', 'scientificName': 'Arctocephalus tropicalis', 'genus': 'Arctocephalus', 'species': 'tropicalis', 'family': 'Otariidae', 'order': 'Carnivora', 'classe': 'Mammalia', 'quantity': 14, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 41, 'popularName': 'garça-moura', 'scientificName': 'Ardea cocoi', 'genus': 'Ardea', 'species': 'cocoi', 'family': 'Ardeidae', 'order': 'Pelecaniformes', 'classe': 'Aves', 'quantity': 3, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 42, 'popularName': 'baleia-minke-anã', 'scientificName': 'Baleonoptera acutorostrata', 'genus': 'Baleonoptera', 'species': 'acutorostrata', 'family': 'Balaenopteridae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 14, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 43, 'popularName': 'baleia-minke-antártica', 'scientificName': 'Balaenoptera bonaerensis', 'genus': 'Balaenoptera', 'species': 'bonaerensis', 'family': 'Balaenopteridae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 44, 'popularName': 'baleia-de-bryde', 'scientificName': 'Baleonoptera brydei', 'genus': 'Baleonoptera', 'species': 'brydei', 'family': 'Balaenopteridae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 45, 'popularName': 'maçarico-branco', 'scientificName': 'Calidris alba', 'genus': 'Calidris', 'species': 'alba', 'family': 'Scolopacidae', 'order': 'Charadriiformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 46, 'popularName': 'maçarico-de-papo-vermelho', 'scientificName': 'Calidris canutus', 'genus': 'Calidris', 'species': 'canutus', 'family': 'Scolopacidae', 'order': 'Charadriiformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 47, 'popularName': 'cação-mangona', 'scientificName': 'Carcharias taurus', 'genus': 'Carcharias', 'species': 'taurus', 'family': 'Odontaspididae', 'order': 'Lamniformes', 'classe': 'Chondrichthyes', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 48, 'popularName': 'tachã', 'scientificName': 'Chauna torquata', 'genus': 'Chauna', 'species': 'torquata', 'family': 'Anhimidae', 'order': 'Anseriformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 49, 'popularName': 'baiacu', 'scientificName': 'Chilomycterus spinosus', 'genus': 'Chilomycterus', 'species': 'spinosus', 'family': 'Tetraodontidae', 'order': 'Tetraodontiformes', 'classe': 'Actinopterygii', 'quantity': 4, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 50, 'popularName': 'pombo-doméstico', 'scientificName': 'Columba livia', 'genus': 'Columba', 'species': 'livia', 'family': 'Columbidae', 'order': 'Columbiformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 51, 'popularName': 'pomba-do-cabo', 'scientificName': 'Daption capense', 'genus': 'Daption', 'species': 'capense', 'family': 'Procellariidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 52, 'popularName': 'gambá-comum', 'scientificName': 'Didelphis marsupialis', 'genus': 'Didelphis', 'species': 'marsupialis', 'family': 'Didelphidae', 'order': 'Didelphimorphia', 'classe': 'Mammalia', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 53, 'popularName': 'cobra-de-capim', 'scientificName': 'Erythrolamprus poecilogyrus', 'genus': 'Erythrolamprus', 'species': 'poecilogyrus', 'family': 'Dipsadidae', 'order': 'Squamata', 'classe': 'Reptilia', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 54, 'popularName': 'galinhola', 'scientificName': 'Gallinula chloropus', 'genus': 'Gallinula', 'species': 'chloropus', 'family': 'Scolopacidae', 'order': 'Charadriiformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 55, 'popularName': 'cachalote-anão', 'scientificName': 'Kogia sima', 'genus': 'Kogia', 'species': 'sima', 'family': 'Kogiidae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 56, 'popularName': 'lontra-neotropical', 'scientificName': 'Lontra longicaudis', 'genus': 'Lontra', 'species': 'longicaudis', 'family': 'Mustelidae', 'order': 'Carnivora', 'classe': 'Mammalia', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 57, 'popularName': 'medusa-mármore', 'scientificName': 'Lychnorhiza lucerna', 'genus': 'Lychnorhiza', 'species': 'lucerna', 'family': 'Lychnorhizidae', 'order': 'Rhizostomeae', 'classe': 'Scyphozoa', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 58, 'popularName': 'petrel-gigante', 'scientificName': 'Macronectes giganteus', 'genus': 'Macronectes', 'species': 'giganteus', 'family': 'Procellariidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 59, 'popularName': 'savacu', 'scientificName': 'Nycticorax nycticorax', 'genus': 'Nycticorax', 'species': 'nycticorax', 'family': 'Ardeidae', 'order': 'Pelecaniformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 60, 'popularName': 'papa-pinto', 'scientificName': 'Philodryas patagoniensis', 'genus': 'Philodryas', 'species': 'patagoniensis', 'family': 'Dipsadidae', 'order': 'Squamata', 'classe': 'Reptilia', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 61, 'popularName': 'piau-preto', 'scientificName': 'Phoebetria fusca', 'genus': 'Phoebetria', 'species': 'fusca', 'family': 'Diomedeidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 62, 'popularName': 'caravela-portuguesa', 'scientificName': 'Physalia physalis', 'genus': 'Physalia', 'species': 'physalis', 'family': 'Physaliidae', 'order': 'Siphonophora', 'classe': 'Hydrozoa', 'quantity': 10, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 63, 'popularName': 'mergulhão-grande', 'scientificName': 'Podicephorus major', 'genus': 'Podicephorus', 'species': 'major', 'family': 'Podicipedidae', 'order': 'Podicipediformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 64, 'popularName': 'pardela-de-óculos', 'scientificName': 'Procellaria conspicillata', 'genus': 'Procellaria', 'species': 'conspicillata', 'family': 'Procellariidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 3, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 65, 'popularName': 'grazina-mole', 'scientificName': 'Pterodroma mollis', 'genus': 'Pterodroma', 'species': 'mollis', 'family': 'Procellariidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 66, 'popularName': 'teiú', 'scientificName': 'Salvator merianae', 'genus': 'Salvator', 'species': 'merianae', 'family': 'Teiidae', 'order': 'Squamata', 'classe': 'Reptilia', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 67, 'popularName': 'trinta-réis-de-bico-vermelho', 'scientificName': 'Sterna hirundinacea', 'genus': 'Sterna', 'species': 'hirundinacea', 'family': 'Sternidae', 'order': 'Charadriiformes', 'classe': 'Aves', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 68, 'popularName': 'polícia-inglesa-do-sul', 'scientificName': 'Sturnella superciliaris', 'genus': 'Sturnella', 'species': 'superciliaris', 'family': 'Icteridae', 'order': 'Passeriformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 69, 'popularName': 'maria-faceira', 'scientificName': 'Syrigma sibilatrix', 'genus': 'Syrigma', 'species': 'sibilatrix', 'family': 'Ardeidae', 'order': 'Pelecaniformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 70, 'popularName': 'albatroz-errante', 'scientificName': 'Diomedea exulans', 'genus': 'Diomedea', 'species': 'exulans', 'family': 'Procellariidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 71, 'popularName': 'tamoatá', 'scientificName': 'Hoplosternum littorale', 'genus': 'Hoplosternum', 'species': 'littorale', 'family': 'Callichthyidae', 'order': 'Siluriformes', 'classe': 'Actinopterygii', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 72, 'popularName': null, 'scientificName': 'Myliobatis goodei', 'genus': 'Myliobatis', 'species': 'goodei', 'family': 'Myliobatidae', 'order': 'Myliobatiformes', 'classe': 'Chondrichthyes', 'quantity': 3, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 73, 'popularName': 'moreia-pintada', 'scientificName': 'Gymnothorax ocellatus', 'genus': 'Gymnothorax', 'species': 'ocellatus', 'family': 'Muraenidae', 'order': 'Anguilliformes', 'classe': 'Actinopterygii', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 74, 'popularName': 'treme-treme', 'scientificName': 'Narcine brasiliensis', 'genus': 'Narcine', 'species': 'brasiliensis', 'family': 'Narcinidae', 'order': 'Torpediniformes', 'classe': 'Chondrichthyes', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 75, 'popularName': null, 'scientificName': 'Arctocephalus sp.', 'genus': 'Arctocephalus', 'species': 'sp.', 'family': 'Otariidae', 'order': 'Carnivora', 'classe': 'Mammalia', 'quantity': 113, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 76, 'popularName': null, 'scientificName': 'Balaenoptera sp.', 'genus': 'Balaenoptera', 'species': 'sp.', 'family': 'Balaenopteridae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 12, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 77, 'popularName': null, 'scientificName': 'Stercorarius sp.', 'genus': 'Stercorarius', 'species': 'sp.', 'family': 'Stercorariidae', 'order': 'Charadriiformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 78, 'popularName': null, 'scientificName': 'Tursiops sp.', 'genus': 'Tursiops', 'species': 'sp.', 'family': 'Delphinidae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 38, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 79, 'popularName': null, 'scientificName': 'Thalassarche sp.', 'genus': 'Thalassarche', 'species': 'sp.', 'family': 'Diomedeidae', 'order': 'Procellariiformes', 'classe': 'Mammalia', 'quantity': 5, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 80, 'popularName': null, 'scientificName': 'Trachemys sp.', 'genus': 'Trachemys', 'species': 'sp.', 'family': 'Emydidae', 'order': 'Testudines', 'classe': 'Reptilia', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 81, 'popularName': null, 'scientificName': null, 'genus': null, 'species': null, 'family': 'Otariidae', 'order': 'Carnivora', 'classe': 'Mammalia', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 82, 'popularName': null, 'scientificName': null, 'genus': null, 'species': null, 'family': null, 'order': 'Testudines', 'classe': 'Reptilia', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 83, 'popularName': null, 'scientificName': null, 'genus': null, 'species': null, 'family': null, 'order': null, 'classe': 'Aves', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 84, 'popularName': null, 'scientificName': null, 'genus': null, 'species': null, 'family': null, 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 85, 'popularName': 'graxaim-do-mato', 'scientificName': 'Cerdocyon thous', 'genus': 'Cerdocyon', 'species': 'thous', 'family': 'Canidae', 'order': 'Carnivora', 'classe': 'Mammalia', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 86, 'popularName': 'quero-quero', 'scientificName': 'Vanellus chilensis', 'genus': 'Vanellus', 'species': 'chilensis', 'family': 'Charadriidae', 'order': 'Charadriiformes', 'classe': 'Aves', 'quantity': 5, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 87, 'popularName': null, 'scientificName': null, 'genus': null, 'species': null, 'family': null, 'order': null, 'classe': 'Gastropoda', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 88, 'popularName': 'pica-pau-do-campo', 'scientificName': 'Colaptes campestris', 'genus': 'Colaptes', 'species': 'campestris', 'family': 'Picidae', 'order': 'Piciformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 89, 'popularName': 'tuco-tuco-das-dunas', 'scientificName': 'Ctenomys flamarioni', 'genus': 'Ctenomys', 'species': 'flamarioni', 'family': 'Ctenomyidae', 'order': 'Rodentia', 'classe': 'Mammalia', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 90, 'popularName': 'coruja-buraqueira', 'scientificName': 'Athene cunicularia', 'genus': 'Athene', 'species': 'cunicularia', 'family': 'Strigidae', 'order': 'Strigiformes', 'classe': 'Aves', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 91, 'popularName': 'tucano-de-bico-verde', 'scientificName': 'Ramphastos dicolorus', 'genus': 'Ramphastos', 'species': 'dicolorus', 'family': 'Ramphastidae', 'order': 'Piciformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 92, 'popularName': null, 'scientificName': null, 'genus': null, 'species': null, 'family': null, 'order': null, 'classe': 'Mammalia', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 93, 'popularName': 'raia-viola', 'scientificName': 'Rhinobatos horkelii', 'genus': 'Rhinobatos', 'species': 'horkelii', 'family': 'Rhinobatidae', 'order': 'Rajiformes', 'classe': 'Chondrichthyes', 'quantity': 3, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 94, 'popularName': null, 'scientificName': null, 'genus': null, 'species': null, 'family': null, 'order': 'Anguilliformes', 'classe': 'Actinopterygii', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 95, 'popularName': null, 'scientificName': null, 'genus': null, 'species': null, 'family': 'Ziphiidae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 96, 'popularName': null, 'scientificName': null, 'genus': null, 'species': null, 'family': null, 'order': 'Squamata', 'classe': 'Reptilia', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 97, 'popularName': null, 'scientificName': null, 'genus': null, 'species': null, 'family': null, 'order': null, 'classe': 'Chondrichthyes', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 98, 'popularName': 'pica-pau-verde-barrado', 'scientificName': 'Colaptes melanochloros', 'genus': 'Colaptes', 'species': 'melanochloros', 'family': 'Picidae', 'order': 'Piciformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 99, 'popularName': 'flamingo-chileno', 'scientificName': 'Phoenicopterus chilensis', 'genus': 'Phoenicopterus', 'species': 'chilensis', 'family': 'Phoenicopteridae', 'order': 'Phoenicopteriformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 100, 'popularName': 'baleia-piloto-de-barbatana-longa', 'scientificName': 'Globicephala melas', 'genus': 'Globicephala', 'species': 'melas', 'family': 'Delphinidae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 101, 'popularName': 'bagre-branco', 'scientificName': 'Genidens barbus', 'genus': 'Genidens', 'species': 'barbus', 'family': 'Ariidae', 'order': 'Siluriformes', 'classe': 'Actinopterygii', 'quantity': 3, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 102, 'popularName': null, 'scientificName': 'Lagocephalus sp', 'genus': 'Lagocephalus', 'species': 'sp', 'family': 'Tetraodontidae', 'order': 'Tetraodontiformes', 'classe': 'Actinopterygii', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 103, 'popularName': 'urubu-de-cabeça-vermelha', 'scientificName': 'Cathartes aura', 'genus': 'Cathartes', 'species': 'aura', 'family': 'Cathartidae', 'order': 'Cathartiformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 104, 'popularName': 'peixe-porco', 'scientificName': 'Aluterus monoceros', 'genus': 'Aluterus', 'species': 'monoceros', 'family': 'Monacanthidae', 'order': 'Tetraodontiformes', 'classe': 'Actinopterygii', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 105, 'popularName': 'cherne', 'scientificName': 'Hyporthodus nigritus', 'genus': 'Hyporthodus', 'species': 'nigritus', 'family': 'Serranidae', 'order': 'Perciformes', 'classe': 'Actinopterygii', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 106, 'popularName': 'boto-de-Buermeister', 'scientificName': 'Phocoena spinipinnis', 'genus': 'Phocoena', 'species': 'spinipinnis', 'family': 'Phocoenidae', 'order': 'Cetacea', 'classe': 'Mammalia', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 107, 'popularName': 'peixe-cachimbo', 'scientificName': 'Syngnathus folletti', 'genus': 'Syngnathus', 'species': 'folletti', 'family': 'Syngnathidae', 'order': 'Syngnathiformes', 'classe': 'Actinopterygii', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 108, 'popularName': 'marreca-caneleira', 'scientificName': 'Dendrocygna bicolor', 'genus': 'Dendrocygna', 'species': 'bicolor', 'family': 'Anatidae', 'order': 'Anseriformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 109, 'popularName': 'trinta-réis-boreal', 'scientificName': 'Sterna hirundo', 'genus': 'Sterna', 'species': 'hirundo', 'family': 'Sternidae', 'order': 'Charadriiformes', 'classe': 'Aves', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 110, 'popularName': 'jacaré-de-papo-amarelo', 'scientificName': 'Caiman latirostris', 'genus': 'Caiman', 'species': 'latirostris', 'family': 'Alligatoridae', 'order': 'Crocodylia', 'classe': 'Reptilia', 'quantity': 2, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 111, 'popularName': 'gaivota-rapineira', 'scientificName': 'Stercorarius antarticus', 'genus': 'Stercorarius', 'species': 'antarticus', 'family': 'Stercorariidae', 'order': 'Charadriiformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 112, 'popularName': 'corredeira-listrada', 'scientificName': 'Lygophis flavifrenatus', 'genus': 'Lygophis', 'species': 'flavifrenatus', 'family': 'Dipsadidae', 'order': 'Squamata', 'classe': 'Reptilia', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 113, 'popularName': 'cagarra-de-cabo-verde', 'scientificName': 'Calonectris edwardsii', 'genus': 'Calonectris', 'species': 'edwardsii', 'family': 'Procellariidae', 'order': 'Procellariiformes', 'classe': 'Aves', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 114, 'popularName': 'cação-noturno', 'scientificName': 'Carcharhinus signatus', 'genus': 'Carcharhinus', 'species': 'signatus', 'family': 'Carcharhinidae', 'order': 'Carcharhiniformes', 'classe': 'Chondrichthyes', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 115, 'popularName': 'golfinho-pintado-do-Atlântico', 'scientificName': 'Stenella frontalis', 'genus': 'Stenella', 'species': 'frontalis', 'family': 'Delphinidae', 'order': 'Cetartiodactyla', 'classe': 'Mammalia', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 116, 'popularName': 'foca-caranguejeira', 'scientificName': 'Lobodon carcinophaga', 'genus': 'Lobodon', 'species': 'carcinophaga', 'family': 'Phocidae', 'order': 'Carnivora', 'classe': 'Mammalia', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 117, 'popularName': 'peixe-porco', 'scientificName': 'Balistes capriscus', 'genus': 'Balistes', 'species': 'capriscus', 'family': 'Balistidae', 'order': 'Tetraodontiformes', 'classe': 'Actinopterygii', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 118, 'popularName': 'tubarão-raposa', 'scientificName': 'Alopias vulinus', 'genus': 'Alopias', 'species': 'vulinus', 'family': 'Alopiidae', 'order': 'Lamniformes', 'classe': 'Chondrichthyes', 'quantity': 1, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 119, 'popularName': 'tartaruga-marinha', 'scientificName': '', 'genus': '', 'species': '', 'family': 'Cheloniidae', 'order': 'Testudines', 'classe': 'Reptilia', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 120, 'popularName': 'Pássaro', 'scientificName': '', 'genus': '', 'species': '', 'family': '', 'order': '', 'classe': '', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 121, 'popularName': 'Sardinha', 'scientificName': 'Sardinella brasiliensis', 'genus': 'Sardinellla', 'species': 'brasiliensis', 'family': '', 'order': '', 'classe': 'Actiniopterygii', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 122, 'popularName': 'Jaguatirica', 'scientificName': '', 'genus': '', 'species': '', 'family': '', 'order': '', 'classe': '', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 123, 'popularName': 'Marlin Azul', 'scientificName': 'Makaira nigricans', 'genus': 'Makaira', 'species': 'nigricans', 'family': 'Istiophoridae', 'order': '', 'classe': '', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''},
    {'id': 124, 'popularName': 'Raia Banjo', 'scientificName': 'Zapteryx brevirostris', 'genus': 'Zapteryx', 'species': 'brevirostris', 'family': 'Rhinobatidae', 'order': 'Rajiformes', 'classe': 'Chondrichthyes', 'quantity': 0, 'imageUrl': '', 'badgeUrl': ''}
  ];

  Future<void> insertAnimals() async {
    WriteBatch batch = _firestore.batch();

    try {
      for (var animal in animalsCreate) {
        DocumentReference docRef = _firestore.collection('animals').doc(animal['id'].toString());
        batch.set(docRef, animal);
      }

      await batch.commit();
      if (kDebugMode) {
        print('All animals inserted successfully.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to insert animals: $e');
      }
    }
  }

  Future<List<AnimalResponse>> getAnimals() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('animals').get();
      for (var doc in querySnapshot.docs) {
        _animals.add(AnimalResponse.fromMap(doc.data() as Map<String, dynamic>));
      }
    } catch (e) {
      if (kDebugMode) {
        print('Falha ao carregar dados da fauna: $e');
      }
    }
    return _animals;
  }

  Future<List<AnimalResponse>> filterAnimals({
    String? classFilter,
    String? orderFilter,
    String? familyFilter,
    String? genusFilter,
    String? speciesFilter,
  }) async {
    try {
      Query query = _firestore.collection('animals');

      if (classFilter != null && classFilter.isNotEmpty) {
        query = query.where('classe', isEqualTo: classFilter);
      }
      if (orderFilter != null && orderFilter.isNotEmpty) {
        query = query.where('order', isEqualTo: orderFilter);
      }
      if (familyFilter != null && familyFilter.isNotEmpty) {
        query = query.where('family', isEqualTo: familyFilter);
      }
      if (genusFilter != null && genusFilter.isNotEmpty) {
        query = query.where('genus', isEqualTo: genusFilter);
      }
      if (speciesFilter != null && speciesFilter.isNotEmpty) {
        query = query.where('species', isEqualTo: speciesFilter);
      }

      QuerySnapshot querySnapshot = await query.get();
      List<AnimalResponse> filteredAnimals = [];
      for (var doc in querySnapshot.docs) {
        filteredAnimals.add(AnimalResponse.fromMap(doc.data() as Map<String, dynamic>));
      }

      return filteredAnimals;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to filter animals: $e');
      }
      return [];
    }
  }

  Future<AnimalResponse?> getAnimalFromSpecies(String species) async {
    try {
      Query query = _firestore.collection('animals');
      query = query.where('scientificName', isEqualTo: species);

      QuerySnapshot querySnapshot = await query.get();
      AnimalResponse? animal;
      for (var doc in querySnapshot.docs) {
        animal = AnimalResponse.fromMap(doc.data() as Map<String, dynamic>);
      }
      return animal;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to filter animals: $e');
      }
      return null;
    }
  }
}