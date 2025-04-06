class GuaritaData {
  final String number;
  final double? latitude;
  final double? longitude;
  final String? place;
  final String? city;

  const GuaritaData({
    required this.number,
    this.latitude,
    this.longitude,
    this.place,
    this.city,
  });
}

const List<GuaritaData> guaritas = [
  GuaritaData(number: "1", latitude: -29.327285, longitude: -49.713305, place: "Praia dos Molhes", city: "Torres"),
  GuaritaData(number: "2", latitude: -29.329640, longitude: -49.714812, place: "Praia Grande", city: "Torres"),
  GuaritaData(number: "3", latitude: -29.332232, longitude: -49.716468, place: "Praia Grande", city: "Torres"),
  GuaritaData(number: "4", latitude: -29.334799, longitude: -49.718565, place: "Praia Grande", city: "Torres"),
  GuaritaData(number: "5", latitude: -29.336839, longitude: -49.720046, place: "Praia Grande", city: "Torres"),
  GuaritaData(number: "6", latitude: -29.337849, longitude: -49.721458, place: "Praia Grande", city: "Torres"),
  GuaritaData(number: "7", latitude: -29.339216, longitude: -49.722104, place: "Praia Grande", city: "Torres"),
  GuaritaData(number: "8", latitude: -29.342486, longitude: -49.724960, place: "Prainha", city: "Torres"),
  GuaritaData(number: "9", latitude: -29.347994, longitude: -49.729511, place: "Praia da Cal", city: "Torres"),
  GuaritaData(number: "To1", latitude: -29.349299, longitude: -49.730485, place: "Praia da Cal", city: "Torres"),
  GuaritaData(number: "10", latitude: -29.350110, longitude: -49.731054, place: "Praia da Cal", city: "Torres"),
  GuaritaData(number: "11", latitude: -29.357599, longitude: -49.733504, place: "Praia da Guarita", city: "Torres"),
  GuaritaData(number: "12", latitude: -29.359623, longitude: -49.736540, place: "Praia de Fora", city: "Torres"),
  GuaritaData(number: "13", latitude: -29.361799, longitude: -49.738696, place: "Praia de Fora", city: "Torres"),
  GuaritaData(number: "14", city: "Torres"),
  GuaritaData(number: "15", city: "Torres"),
  GuaritaData(number: "16", latitude: -29.392340, longitude: -49.764255, place: "Itapeva", city: "Torres"),
  GuaritaData(number: "17", latitude: -29.397289, longitude: -49.768207, place: "Praia Lagoa Jardim", city: "Torres"),
  GuaritaData(number: "18", latitude: -29.408317, longitude: -49.776721, place: "Praia Gaúcha", city: "Torres"),
  GuaritaData(number: "19", latitude: -29.419660, longitude: -49.785420, place: "Praia Weber/Santa Helena", city: "Torres"),
  GuaritaData(number: "20", latitude: -29.425564, longitude: -49.790056, place: "Estrela-do-mar", city: "Torres"),
  GuaritaData(number: "21", latitude: -29.429793, longitude: -49.793785, place: "Praia Real", city: "Torres"),
  GuaritaData(number: "22", latitude: -29.439622, longitude: -49.801567, place: "Praia Paraíso", city: "Torres"),
  GuaritaData(number: "23", latitude: -29.458396, longitude: -49.816110, place: "Arroio Seco", city: "Arroio do Sal"),
  GuaritaData(number: "24", latitude: -29.476348, longitude: -49.829140, place: "Praia Azul", city: "Arroio do Sal"),
  GuaritaData(number: "25", latitude: -29.486263, longitude: -49.837190, city: "Arroio do Sal"),
  GuaritaData(number: "26", latitude: -29.491078, longitude: -49.840587, place: "Parque Tupancy", city: "Arroio do Sal"),
  GuaritaData(number: "28", latitude: -29.501051, longitude: -49.848040, place: "Rondinha", city: "Arroio do Sal"),
  GuaritaData(number: "29", latitude: -29.519218, longitude: -49.861196, place: "Jardim Olívia", city: "Arroio do Sal"),
  GuaritaData(number: "30", latitude: -29.522678, longitude: -49.863723, place: "São Pedro", city: "Arroio do Sal"),
  GuaritaData(number: "31", latitude: -29.530930, longitude: -49.869748, place: "Camboim", city: "Arroio do Sal"),
  GuaritaData(number: "32", latitude: -29.538511, longitude: -49.874523, place: "Balenário São Jorge", city: "Arroio do Sal"),
  GuaritaData(number: "34", latitude: -29.541096, longitude: -49.876752, place: "Areias Brancas", city: "Arroio do Sal"),
  GuaritaData(number: "35", latitude: -29.544201, longitude: -49.878687, city: "Arroio do Sal"),
  GuaritaData(number: "36", latitude: -29.547478, longitude: -49.880967, city: "Arroio do Sal"),
  GuaritaData(number: "37", latitude: -29.550056, longitude: -49.883019, city: "Arroio do Sal"),
  GuaritaData(number: "38", latitude: -29.552081, longitude: -49.884911, place: "Arroio do Sal", city: "Arroio do Sal"),
  GuaritaData(number: "39", latitude: -29.554513, longitude: -49.885974, city: "Arroio do Sal"),
  GuaritaData(number: "40", latitude: -29.556017, longitude: -49.887377, place: "Praia Verde Mar", city: "Arroio do Sal"),
  GuaritaData(number: "41", latitude: -29.558712, longitude: -49.888973, place: "Farol de Arroio do Sal", city: "Arroio do Sal"),
  GuaritaData(number: "Ar01", place: "Jardim Raiante", city: "Arroio do Sal"),
  GuaritaData(number: "Ar02", place: "Vista Alegre", city: "Arroio do Sal"),
  GuaritaData(number: "42", latitude: -29.564281, longitude: -49.893158, place: "Balneário Figueirinha", city: "Arroio do Sal"),
  GuaritaData(number: "43", latitude: -29.570887, longitude: -49.898450, place: "Praia da Âncora", city: "Arroio do Sal"),
  GuaritaData(number: "44", latitude: -29.575534, longitude: -49.901682, place: "Praia de Marambaia", city: "Arroio do Sal"),
  GuaritaData(number: "45", latitude: -29.581491, longitude: -49.905806, place: "Praia Sereia do Mar", city: "Arroio do Sal"),
  GuaritaData(number: "Ar04", place: "Praia Sol Nascente", city: "Arroio do Sal"),
  GuaritaData(number: "46", latitude: -29.587901, longitude: -49.910152, place: "Praia Bom Jesus", city: "Arroio do Sal"),
  GuaritaData(number: "47", latitude: -29.592759, longitude: -49.913734, place: "Praia da Pérola", city: "Arroio do Sal"),
  GuaritaData(number: "Ar05", place: "Rota do Sol", city: "Arroio do Sal"),
  GuaritaData(number: "49", latitude: -29.612332, longitude: -49.926377, place: "Praia Santa Rita", city: "Arroio do Sal"),
  GuaritaData(number: "50", latitude: -29.626444, longitude: -49.935264, place: "Curumim", city: "Capão da Canoa"),
  GuaritaData(number: "51", latitude: -29.629337, longitude: -49.936895, city: "Capão da Canoa"),
  GuaritaData(number: "52", latitude: -29.631607, longitude: -49.938288, city: "Capão da Canoa"),
  GuaritaData(number: "53", latitude: -29.633889, longitude: -49.939689, place: "Praia Arroio Teixeira", city: "Capão da Canoa"),
  GuaritaData(number: "54", latitude: -29.643414, longitude: -49.945324, place: "Praia da Conceição", city: "Capão da Canoa"),
  GuaritaData(number: "55", latitude: -29.645826, longitude: -49.947127, place: "Arroio Teixeira", city: "Capão da Canoa"),
  GuaritaData(number: "56", latitude: -29.648685, longitude: -49.948783, city: "Capão da Canoa"),
  GuaritaData(number: "57", latitude: -29.650801, longitude: -49.950101, city: "Capão da Canoa"),
  GuaritaData(number: "58", latitude: -29.660803, longitude: -49.956026, place: "Praia Village", city: "Capão da Canoa"),
  GuaritaData(number: "59", latitude: -29.680019, longitude: -49.967287, city: "Capão da Canoa"),
  GuaritaData(number: "60", latitude: -29.685654, longitude: -49.970530, place: "Capão Novo", city: "Capão da Canoa"),
  GuaritaData(number: "61", latitude: -29.687442, longitude: -49.971664, place: "Condomínio Costa Serena", city: "Capão da Canoa"),
  GuaritaData(number: "62", latitude: -29.689279, longitude: -49.972644, city: "Capão da Canoa"),
  GuaritaData(number: "64", latitude: -29.714344, longitude: -49.986841, place: "Praia do Barco", city: "Capão da Canoa"),
  GuaritaData(number: "65", latitude: -29.723110, longitude: -49.991629, place: "Jardim Beira Mar", city: "Capão da Canoa"),
  GuaritaData(number: "66", latitude: -29.728116, longitude: -49.994359, place: "Zona Norte", city: "Capão da Canoa"),
  GuaritaData(number: "68", latitude: -29.738052, longitude: -49.999920, place: "Guarani", city: "Capão da Canoa"),
  GuaritaData(number: "69", latitude: -29.741830, longitude: -50.001963, place: "Araçá", city: "Capão da Canoa"),
  GuaritaData(number: "70", latitude: -29.746839, longitude: -50.004642, place: "Farol", city: "Capão da Canoa"),
  GuaritaData(number: "71", latitude: -29.749340, longitude: -50.006355, place: "Zona Nova", city: "Capão da Canoa"),
  GuaritaData(number: "72", latitude: -29.750665, longitude: -50.006603, city: "Capão da Canoa"),
  GuaritaData(number: "73", latitude: -29.753487, longitude: -50.008232, city: "Capão da Canoa"),
  GuaritaData(number: "74", latitude: -29.756079, longitude: -50.009672, city: "Capão da Canoa"),
  GuaritaData(number: "75", latitude: -29.758137, longitude: -50.011125, place: "Capão da Canoa", city: "Capão da Canoa"),
  GuaritaData(number: "76", latitude: -29.760523, longitude: -50.011943, place: "Letreiro Capão da Canoa", city: "Capão da Canoa"),
  GuaritaData(number: "77", latitude: -29.762507, longitude: -50.013069, place: "Capão da Canoa- Praça do Farol", city: "Capão da Canoa"),
  GuaritaData(number: "78", latitude: -29.764082, longitude: -50.013859, city: "Capão da Canoa"),
  GuaritaData(number: "79", latitude: -29.766620, longitude: -50.015203, city: "Capão da Canoa"),
  GuaritaData(number: "80", latitude: -29.769564, longitude: -50.016986, city: "Capão da Canoa"),
  GuaritaData(number: "81", latitude: -29.772350, longitude: -50.018477, city: "Capão da Canoa"),
  GuaritaData(number: "82", latitude: -29.775024, longitude: -50.019762, city: "Xangri-lá"),
  GuaritaData(number: "83", latitude: -29.776795, longitude: -50.020650, city: "Xangri-lá"),
  GuaritaData(number: "84", latitude: -29.779106, longitude: -50.021768, city: "Xangri-lá"),
  GuaritaData(number: "85", latitude: -29.781915, longitude: -50.023127, place: "Praia de Atlântida", city: "Xangri-lá"),
  GuaritaData(number: "86", latitude: -29.783849, longitude: -50.024076, place: "Plataforma de Atlântida", city: "Xangri-lá"),
  GuaritaData(number: "87", latitude: -29.786865, longitude: -50.025795, city: "Xangri-lá"),
  GuaritaData(number: "88", latitude: -29.788956, longitude: -50.026857, city: "Xangri-lá"),
  GuaritaData(number: "89", latitude: -29.793487, longitude: -50.029419, city: "Xangri-lá"),
  GuaritaData(number: "90", latitude: -29.797370, longitude: -50.031484, city: "Xangri-lá"),
  GuaritaData(number: "91", latitude: -29.801573, longitude: -50.033687, city: "Xangri-lá"),
  GuaritaData(number: "92", latitude: -29.804700, longitude: -50.035388, place: "Xangri-lá", city: "Xangri-lá"),
  GuaritaData(number: "93", latitude: -29.808831, longitude: -50.037607, city: "Xangri-lá"),
  GuaritaData(number: "94", latitude: -29.812590, longitude: -50.039588, city: "Xangri-lá"),
  GuaritaData(number: "95", latitude: -29.819857, longitude: -50.043433, place: "Remanso", city: "Xangri-lá"),
  GuaritaData(number: "96", latitude: -29.825293, longitude: -50.046417, place: "Praia Marina/Villas Resort", city: "Xangri-lá"),
  GuaritaData(number: "97", latitude: -29.829077, longitude: -50.048303, place: "Maristela", city: "Xangri-lá"),
  GuaritaData(number: "98", latitude: -29.837616, longitude: -50.052975, city: "Xangri-lá"),
  GuaritaData(number: "99", latitude: -29.840796, longitude: -50.054556, place: "Praia Coqueiros", city: "Xangri-lá"),
  GuaritaData(number: "100", latitude: -29.843793, longitude: -50.056194, city: "Xangri-lá"),
  GuaritaData(number: "101", latitude: -29.846662, longitude: -50.057692, place: "Noiva do Mar", city: "Xangri-lá"),
  GuaritaData(number: "102", latitude: -29.849188, longitude: -50.058897, city: "Xangri-lá"),
  GuaritaData(number: "103", latitude: -29.851314, longitude: -50.059838, city: "Xangri-lá"),
  GuaritaData(number: "104", latitude: -29.854671, longitude: -50.061578, city: "Xangri-lá"),
  GuaritaData(number: "105", latitude: -29.857561, longitude: -50.063012, place: "Rainha do Mar", city: "Xangri-lá"),
  GuaritaData(number: "106", latitude: -29.861664, longitude: -50.065007, place: "Praia Mariápolis", city: "Osório"),
  GuaritaData(number: "107", latitude: -29.868184, longitude: -50.068238, city: "Osório"),
  GuaritaData(number: "108", latitude: -29.871128, longitude: -50.069656, place: "Atlântida Sul", city: "Osório"),
  GuaritaData(number: "109", latitude: -29.879473, longitude: -50.074078, place: "Atlântida Sul", city: "Osório"),
  GuaritaData(number: "110", latitude: -29.891373, longitude: -50.079475, place: "Imara", city: "Imbé"),
  GuaritaData(number: "111", latitude: -29.894929, longitude: -50.081152, place: "Imara", city: "Imbé"),
  GuaritaData(number: "112", latitude: -29.898554, longitude: -50.082821, place: "Santa Teresinha", city: "Imbé"),
  GuaritaData(number: "113", latitude: -29.901165, longitude: -50.084110, place: "Santa Teresinha", city: "Imbé"),
  GuaritaData(number: "114", latitude: -29.904921, longitude: -50.085917, city: "Imbé"),
  GuaritaData(number: "115", latitude: -29.907088, longitude: -50.086832, place: "Praia de Marisul", city: "Imbé"),
  GuaritaData(number: "116", latitude: -29.910300, longitude: -50.088351, place: "Albatroz", city: "Imbé"),
  GuaritaData(number: "117", latitude: -29.912074, longitude: -50.089188, place: "Albatroz", city: "Imbé"),
  GuaritaData(number: "118", latitude: -29.915545, longitude: -50.090719, place: "Praia Mariluz Norte", city: "Imbé"),
  GuaritaData(number: "119", latitude: -29.917837, longitude: -50.091996, place: "Harmonia", city: "Imbé"),
  GuaritaData(number: "120", latitude: -29.921416, longitude: -50.093583, city: "Imbé"),
  GuaritaData(number: "121", latitude: -29.923799, longitude: -50.094691, place: "Mariluz", city: "Imbé"),
  GuaritaData(number: "122", latitude: -29.927088, longitude: -50.096254, place: "Mariluz", city: "Imbé"),
  GuaritaData(number: "123", latitude: -29.930194, longitude: -50.097796, place: "Mariluz", city: "Imbé"),
  GuaritaData(number: "124", latitude: -29.933977, longitude: -50.099466, city: "Imbé"),
  GuaritaData(number: "125", latitude: -29.937145, longitude: -50.100964, place: "Praia Nordeste", city: "Imbé"),
  GuaritaData(number: "126", latitude: -29.940315, longitude: -50.102467, city: "Imbé"),
  GuaritaData(number: "Im01", place: "Riviera", city: "Imbé"),
  GuaritaData(number: "127", latitude: -29.947518, longitude: -50.105935, place: "Presidente", city: "Imbé"),
  GuaritaData(number: "128", latitude: -29.951243, longitude: -50.107553, place: "Praia Morada do Sol", city: "Imbé"),
  GuaritaData(number: "129", latitude: -29.958617, longitude: -50.110970, place: "Las Olas", city: "Imbé"),
  GuaritaData(number: "130", latitude: -29.961511, longitude: -50.112181, city: "Imbé"),
  GuaritaData(number: "131", latitude: -29.963974, longitude: -50.113279, city: "Imbé"),
  GuaritaData(number: "132", latitude: -29.966647, longitude: -50.114333, place: "Av. Garibaldi", city: "Imbé"),
  GuaritaData(number: "133", latitude: -29.969547, longitude: -50.115346, place: "Av. Santa Rosa", city: "Imbé"),
  GuaritaData(number: "134", latitude: -29.971164, longitude: -50.115908, city: "Imbé"),
  GuaritaData(number: "135", latitude: -29.972668, longitude: -50.116463, city: "Imbé"),
  GuaritaData(number: "136", latitude: -29.973758, longitude: -50.116980, city: "Imbé"),
  GuaritaData(number: "137", latitude: -29.975403, longitude: -50.119105, place: "Barra", city: "Imbé"),
  GuaritaData(number: "138", city: "Tramandaí"),
  GuaritaData(number: "139", city: "Tramandaí"),
  GuaritaData(number: "140", latitude: -29.980954, longitude: -50.120710, city: "Tramandaí"),
  GuaritaData(number: "141", latitude: -29.983784, longitude: -50.122169, city: "Tramandaí"),
  GuaritaData(number: "142", latitude: -29.986496, longitude: -50.123300, city: "Tramandaí"),
  GuaritaData(number: "143", latitude: -29.988563, longitude: -50.124287, city: "Tramandaí"),
  GuaritaData(number: "144", latitude: -29.989778, longitude: -50.124778, city: "Tramandaí"),
  GuaritaData(number: "145", latitude: -29.991166, longitude: -50.125410, place: "Avenida da Igreja", city: "Tramandaí"),
  GuaritaData(number: "146", latitude: -29.992686, longitude: -50.126054, place: "Tramandaí", city: "Tramandaí"),
  GuaritaData(number: "147", latitude: -29.993965, longitude: -50.126596, place: "Tramandaí", city: "Tramandaí"),
  GuaritaData(number: "148", latitude: -29.995545, longitude: -50.127311, place: "Tramandaí", city: "Tramandaí"),
  GuaritaData(number: "149", latitude: -29.997356, longitude: -50.128046, place: "Tramandaí", city: "Tramandaí"),
  GuaritaData(number: "150", latitude: -29.999130, longitude: -50.128631, place: "Tramandaí", city: "Tramandaí"),
  GuaritaData(number: "151", latitude: -30.000803, longitude: -50.129243, city: "Tramandaí"),
  GuaritaData(number: "152", latitude: -30.002757, longitude: -50.129979, city: "Tramandaí"),
  GuaritaData(number: "Tr01", latitude: -30.004345, longitude: -50.130783, place: "Plataforma de Tramandaí", city: "Tramandaí"),
  GuaritaData(number: "153", latitude: -30.006538, longitude: -50.131754, city: "Tramandaí"),
  GuaritaData(number: "154", latitude: -30.009035, longitude: -50.132935, city: "Tramandaí"),
  GuaritaData(number: "155", latitude: -30.019357, longitude: -50.137769, city: "Tramandaí"),
  GuaritaData(number: "Tr02", latitude: -30.011399, longitude: -50.081787, city: "Tramandaí"),
  GuaritaData(number: "157", latitude: -30.021765, longitude: -50.139018, city: "Tramandaí"),
  GuaritaData(number: "158", latitude: -30.026324, longitude: -50.140965, city: "Tramandaí"),
  GuaritaData(number: "159", latitude: -30.031115, longitude: -50.143046, place: "Tramandaí Sul", city: "Tramandaí"),
  GuaritaData(number: "160", latitude: -30.035278, longitude: -50.144687, city: "Tramandaí"),
  GuaritaData(number: "161", latitude: -30.038166, longitude: -50.146026, place: "Nova Tramandaí", city: "Tramandaí"),
  GuaritaData(number: "162", latitude: -30.040862, longitude: -50.147274, city: "Tramandaí"),
  GuaritaData(number: "163", latitude: -30.044851, longitude: -50.149054, city: "Tramandaí"),
  GuaritaData(number: "164", latitude: -30.048124, longitude: -50.150368, city: "Tramandaí"),
  GuaritaData(number: "165", latitude: -30.052278, longitude: -50.152189, city: "Tramandaí"),
  GuaritaData(number: "166", latitude: -30.054966, longitude: -50.153186, city: "Tramandaí"),
  GuaritaData(number: "167", latitude: -30.057561, longitude: -50.154371, place: "Oásis Sul", city: "Tramandaí"),
  GuaritaData(number: "168", latitude: -30.059302, longitude: -50.155061, city: "Tramandaí"),
  GuaritaData(number: "169", latitude: -30.062186, longitude: -50.156376, city: "Tramandaí"),
  GuaritaData(number: "170", latitude: -30.065042, longitude: -50.157570, place: "Jardim Atlântico", city: "Tramandaí"),
  GuaritaData(number: "171", latitude: -30.068203, longitude: -50.158931, city: "Tramandaí"),
  GuaritaData(number: "172", latitude: -30.071158, longitude: -50.160397, place: "Jardim do Éden", city: "Tramandaí"),
  GuaritaData(number: "Tr03", latitude: -30.075051, longitude: -50.162244, place: "Portal do Éden", city: "Tramandaí"),
  GuaritaData(number: "Tr04", latitude: -30.079437, longitude: -50.164583, place: "Balneário de Tiarajú", city: "Tramandaí"),
  GuaritaData(number: "173", latitude: -30.141935, longitude: -50.188585, place: "Salinas", city: "Cidreira"),
  GuaritaData(number: "174", latitude: -30.145637, longitude: -50.189778, place: "Salinas", city: "Cidreira"),
  GuaritaData(number: "174175", latitude: -30.148889, longitude: -50.191005, place: "Plataforma", city: "Cidreira"),
  GuaritaData(number: "175", latitude: -30.152119, longitude: -50.192305, place: "Salinas", city: "Cidreira"),
  GuaritaData(number: "176", latitude: -30.156027, longitude: -50.193914, place: "Salinas", city: "Cidreira"),
  GuaritaData(number: "Tr05", latitude: -30.093402, longitude: -50.114447, place: "Farol", city: "Cidreira"),
  GuaritaData(number: "177", latitude: -30.161791, longitude: -50.196249, place: "Praia de Nazaré", city: "Cidreira"),
  GuaritaData(number: "178", latitude: -30.166830, longitude: -50.198212, city: "Cidreira"),
  GuaritaData(number: "179", latitude: -30.170819, longitude: -50.199478, city: "Cidreira"),
  GuaritaData(number: "180", latitude: -30.174947, longitude: -50.201081, place: "Cidreira", city: "Cidreira"),
  GuaritaData(number: "181", latitude: -30.176775, longitude: -50.201970, city: "Cidreira"),
  GuaritaData(number: "182", latitude: -30.178970, longitude: -50.202751, city: "Cidreira"),
  GuaritaData(number: "183", latitude: -30.182797, longitude: -50.204493, city: "Cidreira"),
  GuaritaData(number: "184", latitude: -30.185182, longitude: -50.205364, city: "Cidreira"),
  GuaritaData(number: "185", latitude: -30.186983, longitude: -50.206106, city: "Cidreira"),
  GuaritaData(number: "186", latitude: -30.190131, longitude: -50.207301, city: "Cidreira"),
  GuaritaData(number: "187", latitude: -30.192629, longitude: -50.208248, city: "Cidreira"),
  GuaritaData(number: "188", latitude: -30.196328, longitude: -50.209742, city: "Cidreira"),
  GuaritaData(number: "189", latitude: -30.204384, longitude: -50.212748, city: "Cidreira"),
  GuaritaData(number: "190", latitude: -30.207122, longitude: -50.213915, city: "Cidreira"),
  GuaritaData(number: "191", latitude: -30.211526, longitude: -50.215404, city: "Cidreira"),
  GuaritaData(number: "192", latitude: -30.215950, longitude: -50.217144, city: "Cidreira"),
  GuaritaData(number: "193", latitude: -30.221565, longitude: -50.219206, city: "Cidreira"),
  GuaritaData(number: "194", latitude: -30.224719, longitude: -50.220394, place: "Praia Costa do Sol", city: "Cidreira"),
  GuaritaData(number: "195", latitude: -30.226583, longitude: -50.221043, city: "Cidreira"),
  GuaritaData(number: "196", latitude: -30.229626, longitude: -50.222199, city: "Cidreira"),
  GuaritaData(number: "196197", latitude: -30.233261, longitude: -50.223617, city: "Cidreira"),
  GuaritaData(number: "1962", latitude: -30.236100, longitude: -50.225034, place: "Rua K", city: "Cidreira"),
  GuaritaData(number: "197", latitude: -30.238913, longitude: -50.225926, place: "Balneário Pinhal", city: "Balneário Pinhal"),
  GuaritaData(number: "198", latitude: -30.242940, longitude: -50.227540, place: "Balneário Pinhal", city: "Balneário Pinhal"),
  GuaritaData(number: "199", latitude: -30.248460, longitude: -50.229784, place: "Balneário Pinhal", city: "Balneário Pinhal"),
  GuaritaData(number: "200", latitude: -30.254648, longitude: -50.232253, place: "Balneário Pinhal", city: "Balneário Pinhal"),
  GuaritaData(number: "201", latitude: -30.258909, longitude: -50.233871, place: "Balneário Pinhal", city: "Balneário Pinhal"),
  GuaritaData(number: "202", latitude: -30.263388, longitude: -50.235657, place: "Balneário Pinhal", city: "Balneário Pinhal"),
  GuaritaData(number: "203", latitude: -30.267153, longitude: -50.237063, place: "Balneário Pinhal", city: "Balneário Pinhal"),
  GuaritaData(number: "204", latitude: -30.271643, longitude: -50.238954, place: "Pinhal Sul", city: "Balneário Pinhal"),
  GuaritaData(number: "205", latitude: -30.275271, longitude: -50.240379, place: "Pinhal Sul", city: "Balneário Pinhal"),
  GuaritaData(number: "206", latitude: -30.280619, longitude: -50.242550, place: "Pinhal Sul", city: "Balneário Pinhal"),
  GuaritaData(number: "207", latitude: -30.285545, longitude: -50.244552, place: "Magistério", city: "Balneário Pinhal"),
  GuaritaData(number: "208", latitude: -30.289832, longitude: -50.246368, place: "Magistério", city: "Balneário Pinhal"),
  GuaritaData(number: "209", latitude: -30.294218, longitude: -50.248198, place: "Magistério", city: "Balneário Pinhal"),
  GuaritaData(number: "210", latitude: -30.297945, longitude: -50.249543, place: "Magistério", city: "Balneário Pinhal"),
  GuaritaData(number: "211", latitude: -30.301725, longitude: -50.251121, place: "Magistério", city: "Balneário Pinhal"),
  GuaritaData(number: "212", latitude: -30.333436, longitude: -50.263792, place: "Quintão", city: "Palmares do Sul"),
  GuaritaData(number: "213", latitude: -30.336395, longitude: -50.264829, place: "Quintão", city: "Palmares do Sul"),
  GuaritaData(number: "214", latitude: -30.339236, longitude: -50.266027, place: "Quintão", city: "Palmares do Sul"),
  GuaritaData(number: "215", latitude: -30.341494, longitude: -50.266956, place: "Quintão", city: "Palmares do Sul"),
  GuaritaData(number: "216", latitude: -30.344699, longitude: -50.268079, place: "Quintão", city: "Palmares do Sul"),
  GuaritaData(number: "217", latitude: -30.346868, longitude: -50.268995, place: "Quintão", city: "Palmares do Sul"),
  GuaritaData(number: "218", latitude: -30.350321, longitude: -50.270365, city: "Palmares do Sul"),
  GuaritaData(number: "219", latitude: -30.354344, longitude: -50.271866, place: "Rei do Peixe", city: "Palmares do Sul"),
  GuaritaData(number: "220", latitude: -30.359214, longitude: -50.273739, city: "Palmares do Sul"),
  GuaritaData(number: "221", latitude: -30.363378, longitude: -50.275405, city: "Palmares do Sul"),
  GuaritaData(number: "222", latitude: -30.366738, longitude: -50.276552, place: "Praia do Frade", city: "Palmares do Sul"),
  GuaritaData(number: "223", latitude: -30.370594, longitude: -50.277870, place: "Santa Rita", city: "Palmares do Sul"),
  GuaritaData(number: "224", latitude: -30.380698, longitude: -50.281378, place: "Santa Rita", city: "Palmares do Sul"),
  GuaritaData(number: "Pa01", latitude: -30.232839, longitude: -50.170664, place: "Dunas Claras", city: "Palmares do Sul"),
  GuaritaData(number: "2241", latitude: -30.399720, longitude: -50.288702, place: "Farol Berta - Dunas Altas", city: "Palmares do Sul"),
  GuaritaData(number: "2242", latitude: -30.515650, longitude: -50.344095, place: "Bacopari", city: "Mostardas"),
  GuaritaData(number: "2243", latitude: -30.563377, longitude: -50.375285, place: "Navio - Monte Athos", city: "Mostardas"),
  GuaritaData(number: "225", latitude: -30.702058, longitude: -50.479820, place: "Farol da Solidão", city: "Mostardas"),
  GuaritaData(number: "225226", latitude: -30.847303, longitude: -50.581218, place: "Navio 2", city: "Mostardas"),
  GuaritaData(number: "226", latitude: -30.974476, longitude: -50.677515, place: "São Simão", city: "Mostardas"),
  GuaritaData(number: "2261", latitude: -31.068700, longitude: -50.739458, place: "Pilares - Porto dos Casais", city: "Mostardas"),
  GuaritaData(number: "2262", latitude: -31.097250, longitude: -50.758222, place: "Praia do Pai João", city: "Mostardas"),
  GuaritaData(number: "227", latitude: -31.153680, longitude: -50.808618, place: "Balneário Mostardense", city: "Mostardas"),
  GuaritaData(number: "Ta01", latitude: -31.125000, longitude: -50.520421, place: "Praia Coqueiro", city: "Tavares"),
  GuaritaData(number: "2271", latitude: -31.249879, longitude: -50.905607, place: "Farol de Mostardas", city: "Tavares"),
  GuaritaData(number: "2272", latitude: -31.358498, longitude: -51.039448, place: "Barra da Lagoa do Peixe", city: "Tavares"),
  GuaritaData(number: "BeTo01", latitude: -29.102217, longitude: -49.351566, place: "Bela Torres", city: "Santa Catarina"),
  GuaritaData(number: "MarGro01", latitude: -32.317780, longitude: -51.593568, place: "Praia do Mar Grosso", city: "São José do Norte"),
];

GuaritaData getGuaritaDataByNumber(String number) {
  return guaritas.firstWhere((guarita) => guarita.number == number, orElse: () => GuaritaData(number: "0", place: "Não encontrado", city: "Não encontrado"));
}

GuaritaData getGuaritaDataByCity(String city) {
  return guaritas.firstWhere((guarita) => guarita.city == city, orElse: () => GuaritaData(number: "0", place: "Não encontrado", city: "Não encontrado"));
}