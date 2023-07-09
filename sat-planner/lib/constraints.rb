# Add constraint 1 to the clauses list.
#
# Constraint 1: No participant can play with themselves
# (∀ i, k, l: -x_iikl)
#
# @param clauses [Array] the clauses list
# @param map [Array] the map from initial space to CNF space
# @param np [Integer] the number of participants
# @param nd [Integer] the number of days
# @param nh [Integer] the number of available hours
def add_constraint_1!(clauses, map, np, nd, nh)
  for i in 0...np
    for k in 0...nd
      for l in 0...nh
        clauses << [-map[i][i][k][l]]
      end
    end
  end
end

# Add constraint 2 to the clauses list.
#
# Constraint 2: All participants must play twice with each other, once as
# visitors and once as locals
# (∀ i, j| i != j: (∃ k, l| : x_ijkl))
#
# @param clauses [Array] the clauses list
# @param map [Array] the map from initial space to CNF space
# @param np [Integer] the number of participants
# @param nd [Integer] the number of days
# @param nh [Integer] the number of available hours
def add_constraint_2!(clauses, map, np, nd, nh)
  for i in 0...np
    for j in 0...np
      next if i == j

      clause = []
      for k in 0...nd
        for l in 0...nh
          clause << map[i][j][k][l]
        end
      end

      clauses << clause
    end
  end
end

# Add constraint 3 to the clauses list.
#
# Constraint 3: Two games can't occur at the same time
# Constraint 3.1:
# (∀ i, j, k, l | i != j : x_ijkl => -(∃ u, v| (i != u v j != v) ^ u != v : x_uvkl))
#
# Constraint 3.2:
# (∀ i, j, k, l | i != j ^ l < h-2 : x_ijkl => -(∃ u, v | (i != u v j != v) ^ u != v:x_uvk(l+1)}))
#
# @param clauses [Array] the clauses list
# @param map [Array] the map from initial space to CNF space
# @param np [Integer] the number of participants
# @param nd [Integer] the number of days
# @param nh [Integer] the number of available hours
def add_constraint_3!(clauses, map, np, nd, nh)
  for i in 0...np
    for j in 0...np
      next if i == j

      for k in 0...nd
        for l in 0...nh
          not_x_ijkl = -map[i][j][k][l]

          for u in 0...np
            for v in 0...np
              next if (i == u && j == v) || (u == v)
              # Constraint 3.1
              clauses << [not_x_ijkl, -map[u][v][k][l]]

              # Constraint 3.2
              next if l >= nh - 1
              clauses << [not_x_ijkl, -map[u][v][k][l + 1]]
            end
          end
        end
      end
    end
  end
end

# Add constraint 4 to the clauses list.
#
# Constraint 4: A participant can play at most once per day
# (∀ i, j, k, l | i != j : x_ijkl => -(∃ p, q | q != l :x_ipkq v x_pjkq v x_jpkq v x_pikq))
#
# @param clauses [Array] the clauses list
# @param map [Array] the map from initial space to CNF space
# @param np [Integer] the number of participants
# @param nd [Integer] the number of days
# @param nh [Integer] the number of available hours
def add_constraint_4!(clauses, map, np, nd, nh)
  for i in 0...np
    for j in 0...np
      next if i == j

      for k in 0...nd
        for l in 0...nh
          not_x_ijkl = -map[i][j][k][l]

          for _p in 0...np
            for q in 0...nh
              next if q == l

              clauses << [not_x_ijkl, -map[i][_p][k][q]]
              clauses << [not_x_ijkl, -map[_p][j][k][q]]
              clauses << [not_x_ijkl, -map[j][_p][k][q]]
              clauses << [not_x_ijkl, -map[_p][i][k][q]]
            end
          end
        end
      end
    end
  end
end

# Add constraint 4 to the clauses list.
#
# # Constraint 5: A participant can't play on two consecutive days
# (∀ i, j, k, l | i != j ^ k < d - 1 : x_ijkl => -(∃ p, q | :x_ip(k+1)q v x_pj(k+1)q))
#
# @param clauses [Array] the clauses list
# @param map [Array] the map from initial space to CNF space
# @param np [Integer] the number of participants
# @param nd [Integer] the number of days
# @param nh [Integer] the number of available hours
def add_constraint_5!(clauses, map, np, nd, nh)
  for i in 0...np
    for j in 0...np
      next if i == j

      for k in 0...nd
        next if k >= nd - 1

        for l in 0...nh
          not_x_ijkl = -map[i][j][k][l]

          for _p in 0...np
            for q in 0...nh
              clauses << [not_x_ijkl, -map[i][_p][k + 1][q]]
              clauses << [not_x_ijkl, -map[_p][j][k + 1][q]]
            end
          end
        end
      end
    end
  end
end
