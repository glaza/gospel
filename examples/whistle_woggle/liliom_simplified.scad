color([0.0000, 0.0000, 0.0000, 1.0000]) liliom_background();
color([1.0000, 1.0000, 0.0000, 1.0000]) liliom_outline();

module liliom_background()
    polygon(
        points=
            [[-77.638, 65.405], [-79.503, 67.466], [-80.826, 69.893], [-81.76, 72.53], [-82.46, 75.217], [-83.396, 74.088], [-84.631, 73.263], [-86.054, 72.762], [-87.553, 72.599], [-89.016, 72.794], [-90.331, 73.363], [-91.386, 74.323], [-92.069, 75.692], [-92.424, 77.888], [-92.209, 80.262], [-91.828, 81.14], [-91.233, 81.61], [-90.402, 81.523], [-89.31, 80.726], [-88.086, 80.885], [-87.018, 81.38], [-85.382, 83.123], [-84.459, 85.445], [-84.305, 87.836], [-84.405, 91.605], [-85.519, 95.268], [-86.467, 96.899], [-87.682, 98.31], [-89.169, 99.437], [-90.931, 100.216], [-92.547, 100.314], [-93.879, 99.585], [-96.018, 96.946], [-96.985, 95.685], [-97.992, 94.894], [-99.119, 94.898], [-100.446, 96.022], [-102.142, 97.922], [-103.485, 100.133], [-104.432, 102.559], [-104.944, 105.101], [-104.979, 107.663], [-104.496, 110.147], [-103.454, 112.456], [-101.812, 114.493], [-99.877, 115.841], [-97.717, 116.695], [-95.419, 117.076], [-93.075, 117.005], [-90.772, 116.504], [-88.603, 115.594], [-86.655, 114.296], [-85.018, 112.631], [-86.37, 116.292], [-87.563, 120.067], [-88.035, 123.898], [-87.824, 125.816], [-87.223, 127.727], [-85.661, 130.67], [-83.469, 133.14], [-78.563, 137.65], [-77.426, 138.392], [-76.374, 138.527], [-75.389, 138.191], [-74.454, 137.518], [-72.661, 135.701], [-70.852, 134.157], [-68.374, 131.658], [-66.466, 128.702], [-65.372, 125.404], [-65.206, 123.663], [-65.337, 121.88], [-65.811, 119.498], [-66.554, 117.188], [-68.335, 112.663], [-66.485, 114.458], [-64.268, 115.812], [-61.808, 116.696], [-59.227, 117.08], [-56.649, 116.936], [-54.199, 116.233], [-51.998, 114.943], [-50.17, 113.036], [-49.032, 110.994], [-48.391, 108.815], [-48.204, 106.558], [-48.427, 104.281], [-49.017, 102.043], [-49.931, 99.903], [-51.126, 97.919], [-52.557, 96.15], [-53.311, 95.268], [-54.115, 94.796], [-54.925, 94.69], [-55.699, 94.903], [-56.963, 96.103], [-57.558, 98.026], [-58.67, 99.191], [-59.99, 99.86], [-61.43, 100.08], [-62.902, 99.894], [-64.316, 99.346], [-65.585, 98.482], [-66.62, 97.346], [-67.333, 95.982], [-68.712, 92.261], [-69.028, 88.286], [-68.236, 84.399], [-67.411, 82.595], [-66.292, 80.94], [-65.535, 80.55], [-64.677, 80.595], [-62.907, 81.261], [-62.121, 81.518], [-61.486, 81.478], [-61.063, 80.961], [-60.916, 79.783], [-60.709, 78.437], [-60.831, 77.05], [-61.934, 74.491], [-62.851, 73.486], [-63.97, 72.777], [-65.258, 72.446], [-66.684, 72.578], [-68.186, 73.276], [-69.861, 74.318], [-70.576, 74.616], [-71.111, 74.577], [-71.391, 74.06], [-71.34, 72.924], [-72.126, 70.447], [-73.429, 67.946], [-75.15, 65.935], [-76.136, 65.273], [-77.19, 64.927]],
        paths=
            [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 0]]
    );

module liliom_outline()
    polygon(
        points=
            [[-77.67, 65.483], [-79.622, 67.884], [-80.975, 70.168], [-81.883, 72.611], [-82.11, 74.807], [-82.022, 75.704], [-82.214, 75.555], [-84.411, 73.531], [-85.941, 72.743], [-87.443, 72.528], [-88.835, 72.702], [-90.057, 73.207], [-91.066, 74.018], [-91.817, 75.106], [-92.347, 77.274], [-91.95, 81.048], [-91.552, 82.692], [-91.211, 82.23], [-89.549, 80.574], [-88.494, 80.305], [-87.471, 80.621], [-86.503, 81.508], [-85.613, 82.954], [-84.554, 85.97], [-84.215, 89.431], [-84.682, 92.931], [-85.488, 95.222], [-86.575, 97.152], [-87.896, 98.653], [-89.407, 99.663], [-91.7, 100.142], [-92.814, 100.046], [-93.83, 99.632], [-95.919, 97.582], [-97.323, 94.596], [-97.628, 93.83], [-100.761, 96.467], [-102.165, 98.092], [-103.288, 99.849], [-104.132, 101.742], [-104.697, 103.769], [-104.997, 106.384], [-104.822, 108.814], [-104.206, 111.014], [-103.179, 112.94], [-101.772, 114.546], [-100.017, 115.786], [-97.945, 116.616], [-95.586, 116.991], [-93.207, 116.955], [-91.049, 116.585], [-89.111, 115.881], [-87.391, 114.843], [-85.054, 112.568], [-84.703, 112.161], [-85.601, 114.499], [-87.387, 119.387], [-87.962, 122.556], [-87.915, 124.91], [-87.362, 127.26], [-86.502, 129.242], [-85.271, 131.152], [-83.694, 132.956], [-81.797, 134.623], [-78.093, 137.909], [-76.631, 139.332], [-75.084, 137.851], [-71.557, 134.712], [-68.7, 132.059], [-67.257, 130.126], [-66.201, 128.128], [-65.536, 126.068], [-65.261, 123.95], [-65.653, 120.183], [-67.485, 114.869], [-68.55, 112.103], [-68.059, 112.71], [-67.014, 113.835], [-65.23, 115.267], [-63.293, 116.252], [-61.12, 116.821], [-58.627, 117.006], [-56.591, 116.887], [-54.854, 116.479], [-52.777, 115.536], [-51.051, 114.124], [-49.713, 112.4], [-48.799, 110.357], [-48.371, 108.641], [-48.257, 106.759], [-48.463, 104.225], [-49.067, 101.848], [-50.071, 99.627], [-51.476, 97.557], [-55.384, 93.952], [-55.655, 93.752], [-55.752, 94.108], [-56.692, 96.477], [-58.251, 98.727], [-60.159, 99.968], [-61.542, 100.139], [-63.772, 99.704], [-65.73, 98.283], [-67.581, 95.565], [-68.807, 91.902], [-69.009, 89.419], [-68.857, 86.859], [-68.292, 84.561], [-67.09, 82.013], [-65.607, 80.515], [-64.695, 80.327], [-63.734, 80.553], [-62.015, 82.249], [-61.702, 82.686], [-61.612, 82.571], [-61.463, 81.945], [-60.906, 78.538], [-61.108, 75.868], [-62.285, 73.909], [-63.854, 72.881], [-65.772, 72.528], [-66.914, 72.646], [-68.044, 73.086], [-69.589, 74.106], [-70.939, 75.474], [-71.24, 75.854], [-71.18, 75.517], [-71.26, 73.014], [-71.837, 71.119], [-72.786, 69.182], [-75.709, 65.328], [-76.65, 64.603], [-77.67, 65.483], [-76.901, 75.854], [-76.901, 86.28], [-77.835, 86.28], [-78.77, 86.224], [-79.145, 83.328], [-79.777, 80.61], [-80.889, 77.413], [-81.49, 75.679], [-81.61, 74.49], [-81.409, 72.811], [-80.823, 71.021], [-78.596, 67.348], [-76.928, 65.427], [-75.454, 66.39], [-73.788, 68.547], [-72.599, 70.627], [-71.887, 72.627], [-71.653, 74.546], [-71.778, 75.761], [-72.49, 77.76], [-73.71, 81.436], [-74.323, 84.86], [-74.479, 86.112], [-75.408, 86.28], [-76.303, 86.28], [-76.303, 75.882], [-76.19, 65.577], [-75.454, 66.39], [-86.325, 73.161], [-84.867, 73.852], [-83.291, 75.176], [-81.352, 77.744], [-80.147, 80.884], [-79.484, 84.637], [-79.337, 86.0], [-79.307, 86.28], [-80.141, 86.28], [-80.974, 86.28], [-81.114, 85.551], [-82.046, 82.3], [-83.415, 79.619], [-84.978, 77.881], [-86.669, 76.788], [-88.08, 76.587], [-89.296, 77.012], [-90.314, 78.249], [-91.179, 80.22], [-91.453, 81.074], [-91.578, 80.37], [-91.841, 78.091], [-91.737, 76.377], [-91.273, 75.123], [-90.469, 74.14], [-89.337, 73.435], [-87.888, 73.02], [-86.325, 73.161], [-65.017, 73.082], [-63.785, 73.466], [-62.78, 74.124], [-62.023, 75.04], [-61.532, 76.195], [-61.568, 79.873], [-61.729, 80.863], [-61.789, 80.899], [-61.942, 80.54], [-62.951, 78.182], [-63.989, 77.01], [-65.205, 76.584], [-66.87, 76.926], [-68.606, 78.208], [-69.739, 79.494], [-70.618, 81.011], [-71.523, 83.245], [-72.192, 85.85], [-72.278, 86.28], [-73.102, 86.28], [-73.927, 86.28], [-73.877, 85.738], [-73.175, 81.223], [-71.841, 77.65], [-70.163, 75.4], [-67.984, 73.617], [-66.521, 73.059], [-86.522, 77.445], [-85.112, 78.434], [-83.833, 79.93], [-82.185, 83.477], [-81.535, 86.16], [-82.742, 86.263], [-83.948, 86.243], [-84.156, 85.421], [-85.532, 82.008], [-86.433, 80.812], [-87.408, 80.068], [-88.86, 79.814], [-90.332, 80.479], [-90.87, 80.885], [-90.681, 80.35], [-89.382, 77.813], [-88.643, 77.237], [-87.68, 77.115], [-64.39, 77.34], [-63.75, 77.934], [-62.519, 80.44], [-62.324, 80.99], [-62.718, 80.634], [-63.597, 80.046], [-64.718, 79.816], [-65.765, 80.018], [-66.841, 80.834], [-67.795, 82.146], [-68.602, 83.909], [-69.234, 86.075], [-69.28, 86.28], [-70.517, 86.28], [-71.717, 86.149], [-71.558, 85.406], [-70.688, 82.452], [-69.416, 79.943], [-67.189, 77.693], [-65.688, 77.118], [-64.39, 77.34], [-82.578, 86.897], [-82.576, 88.485], [-82.578, 89.98], [-83.108, 89.98], [-83.637, 89.98], [-83.635, 88.448], [-83.631, 86.859], [-82.578, 86.897], [-80.937, 88.41], [-80.937, 90.017], [-81.498, 90.017], [-82.058, 90.017], [-82.058, 88.41], [-82.058, 86.803], [-81.498, 86.803], [-80.937, 86.803], [-79.368, 88.41], [-79.368, 90.017], [-79.928, 90.017], [-80.489, 90.017], [-80.489, 88.41], [-80.489, 86.803], [-79.928, 86.803], [-79.368, 86.803], [-78.442, 86.966], [-78.751, 87.2], [-78.844, 87.037], [-78.535, 86.803], [-78.226, 86.803], [-75.768, 86.956], [-74.834, 87.541], [-74.435, 88.429], [-74.604, 89.031], [-75.066, 89.522], [-76.602, 89.976], [-77.52, 89.848], [-78.238, 89.447], [-78.77, 88.41], [-78.274, 87.403], [-77.153, 86.88], [-75.768, 86.956], [-74.36, 87.079], [-74.36, 87.354], [-74.603, 87.135], [-74.917, 86.86], [-74.674, 86.803], [-74.4, 86.838], [-72.79, 88.41], [-72.79, 90.017], [-73.351, 90.017], [-73.911, 90.017], [-73.911, 88.41], [-73.911, 86.803], [-73.351, 86.803], [-72.79, 86.803], [-71.146, 88.41], [-71.146, 90.017], [-71.707, 90.017], [-72.267, 90.017], [-72.267, 88.41], [-72.267, 86.803], [-71.707, 86.803], [-71.146, 86.803], [-69.576, 88.41], [-69.576, 90.017], [-70.137, 90.017], [-70.698, 90.017], [-70.698, 88.41], [-70.698, 86.803], [-70.137, 86.803], [-69.576, 86.803], [-74.36, 89.756], [-74.671, 90.017], [-74.983, 90.017], [-74.69, 89.759], [-74.379, 89.497], [-74.36, 89.756], [-78.253, 89.995], [-78.533, 90.017], [-78.844, 89.789], [-78.844, 89.561], [-78.564, 89.767], [-78.253, 89.995], [-82.731, 90.559], [-83.057, 91.202], [-83.382, 91.826], [-83.461, 91.501], [-83.59, 90.858], [-83.641, 90.54], [-83.186, 90.54], [-82.731, 90.559], [-80.973, 90.858], [-81.372, 92.042], [-81.611, 92.041], [-81.843, 91.618], [-82.022, 90.895], [-82.075, 90.54], [-81.5, 90.54], [-80.924, 90.54], [-79.47, 90.671], [-79.666, 91.362], [-79.866, 92.035], [-80.339, 90.596], [-79.886, 90.54], [-79.47, 90.671], [-74.435, 90.836], [-75.051, 92.308], [-76.149, 92.963], [-77.321, 92.887], [-78.298, 92.178], [-78.812, 90.933], [-78.864, 90.54], [-76.649, 90.54], [-74.435, 90.54], [-72.865, 90.567], [-72.936, 90.809], [-73.169, 91.587], [-73.332, 92.147], [-73.546, 91.437], [-73.761, 90.634], [-73.314, 90.54], [-72.865, 90.567], [-71.221, 90.783], [-71.743, 92.11], [-72.238, 90.96], [-72.288, 90.54], [-71.754, 90.54], [-71.221, 90.54], [-71.221, 90.783], [-69.697, 91.082], [-69.801, 91.68], [-69.859, 91.736], [-70.473, 90.576], [-70.034, 90.54], [-69.594, 90.54], [-82.137, 92.157], [-82.005, 92.659], [-81.745, 93.174], [-81.178, 93.115], [-81.012, 92.681], [-80.935, 92.287], [-80.722, 91.854], [-80.587, 91.498], [-80.399, 92.159], [-80.312, 92.967], [-80.37, 93.533], [-79.943, 93.828], [-79.457, 93.567], [-79.37, 94.67], [-79.444, 95.922], [-80.079, 95.657], [-81.727, 94.516], [-82.918, 92.973], [-83.18, 92.471], [-82.831, 91.795], [-82.482, 91.119], [-82.379, 91.52], [-70.163, 92.662], [-71.212, 94.215], [-72.299, 95.16], [-73.631, 95.872], [-73.911, 95.989], [-73.904, 93.993], [-73.896, 91.998], [-73.764, 92.409], [-73.734, 92.967], [-73.793, 93.534], [-73.352, 93.829], [-72.872, 93.567], [-72.902, 93.034], [-72.862, 92.248], [-72.656, 91.667], [-72.566, 91.683], [-72.387, 92.125], [-72.243, 92.642], [-72.114, 93.035], [-71.739, 93.231], [-71.359, 93.068], [-71.229, 92.649], [-71.088, 92.11], [-70.84, 91.481], [-70.749, 91.114], [-70.414, 91.779], [-70.163, 92.662], [-68.68, 94.24], [-67.395, 96.963], [-66.041, 98.677], [-64.087, 100.122], [-61.836, 100.68], [-60.16, 100.511], [-58.666, 99.788], [-57.351, 98.507], [-56.213, 96.668], [-55.596, 95.36], [-55.481, 95.062], [-55.02, 95.996], [-53.874, 99.305], [-53.741, 101.092], [-53.953, 102.722], [-54.557, 104.071], [-55.504, 105.228], [-56.741, 106.141], [-58.216, 106.762], [-59.87, 106.971], [-61.579, 106.871], [-63.524, 106.218], [-65.384, 105.087], [-67.103, 103.521], [-68.624, 101.565], [-70.07, 98.802], [-71.149, 95.825], [-71.32, 95.167], [-71.019, 94.853], [-70.058, 93.608], [-69.426, 92.297], [-69.329, 91.999], [-69.122, 92.783], [-68.68, 94.24], [-83.509, 92.988], [-82.345, 94.69], [-81.897, 95.169], [-82.095, 95.86], [-83.144, 98.813], [-84.793, 101.823], [-86.837, 104.236], [-89.17, 105.955], [-91.688, 106.878], [-94.477, 106.878], [-95.931, 106.42], [-97.215, 105.666], [-98.265, 104.663], [-99.017, 103.459], [-99.51, 100.807], [-98.943, 97.696], [-97.969, 95.495], [-97.737, 95.089], [-97.496, 95.673], [-96.62, 97.433], [-95.595, 98.839], [-94.446, 99.867], [-93.195, 100.49], [-90.804, 100.618], [-88.427, 99.717], [-86.133, 97.414], [-84.994, 95.313], [-84.181, 93.02], [-83.946, 92.186], [-83.834, 92.259], [-83.509, 92.988], [-79.368, 92.65], [-79.486, 93.021], [-79.509, 92.481], [-79.391, 92.11], [-74.36, 93.343], [-74.36, 94.427], [-75.326, 94.427], [-76.292, 94.427], [-76.173, 94.189], [-76.173, 93.744], [-76.292, 93.537], [-75.9, 93.423], [-74.659, 92.577], [-74.379, 92.266], [-74.36, 93.343], [-77.829, 93.213], [-77.264, 93.448], [-77.076, 93.761], [-77.034, 94.206], [-76.908, 94.427], [-77.876, 94.427], [-78.844, 94.427], [-78.844, 93.375], [-78.844, 92.324], [-78.483, 92.695], [-74.36, 95.5], [-74.36, 96.125], [-74.939, 96.229], [-78.302, 96.232], [-78.844, 96.132], [-78.844, 95.504], [-78.844, 94.875], [-76.602, 94.875], [-74.36, 94.875], [-74.36, 95.5], [-53.642, 96.047], [-51.858, 97.899], [-50.491, 99.901], [-49.514, 102.103], [-48.9, 104.554], [-48.762, 106.79], [-48.932, 108.897], [-49.55, 110.902], [-50.476, 112.625], [-51.709, 114.066], [-53.249, 115.225], [-56.306, 116.343], [-58.549, 116.515], [-60.869, 116.375], [-62.937, 115.843], [-64.759, 114.968], [-66.417, 113.698], [-67.993, 111.983], [-69.522, 109.636], [-70.984, 106.597], [-72.252, 103.165], [-73.2, 99.638], [-73.762, 96.555], [-73.182, 96.237], [-72.193, 95.742], [-71.784, 95.484], [-71.554, 96.284], [-69.863, 100.477], [-67.505, 103.843], [-64.628, 106.218], [-63.042, 106.983], [-61.382, 107.439], [-58.178, 107.285], [-55.861, 106.208], [-54.14, 104.404], [-53.399, 102.648], [-53.233, 100.556], [-53.579, 98.268], [-54.497, 95.922], [-54.992, 94.915], [-53.642, 96.047], [-98.761, 95.94], [-99.55, 97.92], [-99.968, 99.784], [-100.014, 101.524], [-99.688, 103.134], [-99.02, 104.51], [-98.019, 105.678], [-96.725, 106.604], [-95.175, 107.25], [-93.462, 107.495], [-91.679, 107.4], [-90.018, 106.92], [-88.438, 106.13], [-85.586, 103.692], [-83.253, 100.234], [-81.569, 95.902], [-81.449, 95.471], [-81.249, 95.612], [-79.723, 96.366], [-79.478, 96.619], [-79.667, 97.715], [-80.959, 103.083], [-82.952, 108.152], [-84.193, 110.477], [-85.54, 112.334], [-87.172, 114.023], [-88.948, 115.249], [-90.942, 116.052], [-93.226, 116.47], [-96.549, 116.402], [-99.401, 115.529], [-101.713, 113.885], [-103.415, 111.505], [-104.179, 109.462], [-104.456, 107.133], [-104.259, 104.178], [-103.485, 101.433], [-102.144, 98.919], [-100.245, 96.66], [-98.31, 94.95], [-98.761, 95.94], [-77.667, 96.817], [-77.35, 96.9], [-77.696, 97.387], [-78.144, 97.707], [-78.246, 97.486], [-78.687, 97.118], [-78.937, 97.246], [-79.037, 97.172], [-78.958, 96.794], [-78.454, 96.717], [-73.942, 98.724], [-72.463, 104.252], [-70.227, 109.57], [-69.131, 112.066], [-67.857, 115.354], [-66.528, 118.981], [-65.901, 121.483], [-65.937, 125.541], [-66.683, 127.951], [-67.922, 130.213], [-69.657, 132.336], [-71.893, 134.325], [-75.35, 137.395], [-76.303, 138.335], [-76.303, 117.628], [-76.303, 96.92], [-75.537, 96.831], [-74.547, 96.681], [-74.323, 96.62], [-74.228, 97.186], [-73.942, 98.724], [-76.901, 97.914], [-77.038, 98.437], [-77.322, 98.313], [-77.569, 98.178], [-77.29, 97.708], [-76.92, 97.271], [-76.901, 97.914], [-78.699, 98.014], [-78.433, 98.313], [-78.776, 98.579], [-79.066, 98.924], [-78.945, 99.298], [-78.507, 99.391], [-78.246, 99.023], [-78.098, 98.726], [-77.837, 98.686], [-77.723, 98.859], [-77.325, 99.21], [-77.038, 99.087], [-76.901, 118.646], [-76.901, 138.329], [-77.18, 138.072], [-78.245, 137.058], [-81.049, 134.58], [-83.19, 132.76], [-84.797, 130.975], [-86.391, 128.337], [-87.333, 125.444], [-87.337, 121.408], [-86.681, 118.83], [-85.288, 115.055], [-84.109, 112.028], [-83.067, 109.674], [-80.759, 104.135], [-79.289, 98.601], [-79.116, 97.655], [-78.975, 97.835], [-78.699, 98.014]],
        paths=
            [[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 0], [133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 133, 133], [146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 146], [161, 162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 161], [189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 189, 189], [216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 216, 216], [234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 253, 254, 234], [255, 256, 257, 258, 259, 260, 261, 262, 255], [263, 264, 265, 266, 267, 268, 269, 270, 263], [271, 272, 273, 274, 275, 276, 277, 278, 271], [279, 280, 281, 282, 283, 279], [284, 285, 286, 287, 288, 289, 290, 291, 292, 293, 294, 295, 284], [296, 297, 298, 299, 300, 301, 296, 296], [302, 303, 304, 305, 306, 307, 308, 309, 302], [310, 311, 312, 313, 314, 315, 316, 317, 310], [318, 319, 320, 321, 322, 323, 324, 325, 318], [326, 327, 328, 329, 330, 331, 326], [332, 333, 334, 335, 336, 337, 332], [338, 339, 340, 341, 342, 343, 344, 345, 338], [346, 347, 348, 349, 350, 351, 352, 353, 346], [354, 355, 356, 357, 358, 359, 354], [360, 361, 362, 363, 364, 365, 366, 367, 368, 360], [369, 370, 371, 372, 373, 374, 375, 376, 369], [377, 378, 379, 380, 381, 382, 383, 377], [384, 385, 386, 387, 388, 389, 384], [390, 391, 392, 393, 394, 395, 396, 397, 398, 399, 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 390, 390], [412, 413, 414, 415, 416, 417, 418, 419, 420, 421, 422, 423, 424, 425, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 412], [439, 440, 441, 442, 443, 444, 445, 446, 447, 448, 449, 450, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 465, 466, 467, 468, 469, 470, 471, 472, 439], [473, 474, 475, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 490, 491, 492, 493, 494, 495, 496, 497, 498, 499, 500, 501, 502, 503, 473], [504, 505, 506, 507, 504, 504], [508, 509, 510, 511, 512, 513, 514, 515, 516, 517, 518, 508], [519, 520, 521, 522, 523, 524, 525, 526, 527, 528, 519, 519], [529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 529], [539, 540, 541, 542, 543, 544, 545, 546, 547, 548, 549, 550, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 565, 566, 567, 568, 569, 570, 571, 572, 573, 574, 575, 576, 577, 578, 579, 539], [580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 590, 591, 592, 593, 594, 595, 596, 597, 598, 599, 600, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 615, 616, 617, 618, 619, 620, 580], [621, 622, 623, 624, 625, 626, 627, 628, 629, 630, 621, 621], [631, 632, 633, 634, 635, 636, 637, 638, 639, 640, 641, 642, 643, 644, 645, 646, 647, 648, 649, 650, 651, 631], [652, 653, 654, 655, 656, 657, 658, 652], [659, 660, 661, 662, 663, 664, 665, 666, 667, 668, 669, 670, 671, 672, 673, 674, 675, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 659]]
    );