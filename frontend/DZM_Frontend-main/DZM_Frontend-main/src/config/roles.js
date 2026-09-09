export const Role = {
  general: 0,
  admin: 4,
  teacher: 2,
  teachingDirector: 8,
  user: 1
};

export function getRoles(role) {
  const roles = [0];
  if(checkRoles(role, [Role.user])) roles.push(Role.user);
  if(checkRoles(role, [Role.admin])) roles.push(Role.admin);
  if(checkRoles(role, [Role.teacher])) roles.push(Role.teacher);
  if(checkRoles(role, [Role.teachingDirector])) roles.push(Role.teachingDirector);
  return roles;
}

export function checkRoles(role, roles) {
  for(let i = 0; i < roles.length; i ++) {
    if(roles[i] === Role.general || (role & roles[i]) !== 0) {
      return true;
    }
    return false;
  }
}



export function roleLabel(role) {
  let roles = "";
  if(checkRoles(role, [Role.admin])) roles += "管理员 ";
  if(checkRoles(role, [Role.teacher])) roles += "教师 ";
  if(checkRoles(role, [Role.teachingDirector])) roles += "教学总监 ";
  if(roles.length === 0 && checkRoles(role, [Role.user])) roles += "内部用户";
  if(roles.length === 0) {
    return "普通用户";
  }
  return roles;
}
