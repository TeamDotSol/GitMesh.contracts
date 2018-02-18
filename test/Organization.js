
const expectThrow = require('./helpers/expectThrow')

const Organization = artifacts.require('Organization.sol')
const Repository = artifacts.require('Repository.sol')
const gasPrice = 6000029

contract('Organization', (accounts) => {
    it('should deploy an Org', async () => {
        const instance = await Organization.new(accounts[0])
        if (instance.address === undefined) throw new Error('deployment failed')
    })

    it('should add a role', async () => {
        const instance = await Organization.new(accounts[0])
        await instance.createRole("admin", true, true, true, true)
        const role = await instance.getRole("admin")
        if (!role[0]) throw new Error('deployment failed')
        if (instance.address === undefined) throw new Error('deployment failed')
    })

    it('should promote user to role', async () => {
        const instance = await Organization.new(accounts[0])
        await instance.createRole("admin", true, true, true, true)
        await instance.assignRole(accounts[1], "admin")
        const role = await instance.getMemberRole(accounts[1])
        if (!role) throw new Error('role assignemnt failed')
        if (instance.address === undefined) throw new Error('deployment failed')
    })

    it('should create a repo', async () => {
        const instance = await Organization.new(accounts[0])
        await instance.createRole("admin", true, true, true, true)
        await instance.assignRole(accounts[0], "admin")
        await instance.createRepo("mysweetproject")
        const repoAddress = await instance.getRepo("mysweetproject")
        if (!repoAddress) throw new Error('deployment failed')
        if (instance.address === undefined) throw new Error('deployment failed')
    })

    it('repo should list tags', async () => {
        const instance = await Organization.new(accounts[0])
        await instance.createRole("admin", true, true, true, true)
        await instance.assignRole(accounts[0], "admin")
        await instance.createRepo("mysweetproject")
        const repoAddress = await instance.getRepo("mysweetproject")

        const org = await Repository.at(repoAddress).getTags()

        if (!Array.isArray(org)) throw new Error('tags not fetched')
        if (!repoAddress) throw new Error('deployment failed')
        if (instance.address === undefined) throw new Error('deployment failed')
    })

    
    
    it('should commit to a repo', async () => {
        const instance = await Organization.new()

        await instance.createRole("admin", true, true, true, true)
        await instance.assignRole(accounts[0], "admin")

        await instance.createRepo("mysweetproject")
        const repoAddress = await instance.getRepo.call("mysweetproject")
        const owner = await Repository.at(repoAddress).organization.call()

        await instance.commit("ca82a6dff817ec66", "Qmcpo2iLBikrdz", "mysweetproject", "master")

        const commits = await Repository.at(repoAddress).getCommitHashes.call("master")

        if (!repoAddress) throw new Error('deployment failed')
        if (instance.address === undefined) throw new Error('deployment failed')
    })
})